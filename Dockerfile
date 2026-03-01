FROM docker.io/golang:alpine AS build
ADD --checksum=sha256:337eef46f6c5495c97df80ae6e378521db93da0f8603ef7cffea727075b08d39 https://github.com/prometheus/snmp_exporter/archive/v0.30.1.tar.gz /tmp/snmp_exporter.tar.gz
RUN tar -xzvf /tmp/snmp_exporter.tar.gz --strip-components=1 \
    && go install
RUN mkdir /rootfs \
      && cp /go/snmp.yml /rootfs/ \
    && mkdir /rootfs/bin \
      && cp /go/bin/snmp_exporter /rootfs/bin/ \
    && mkdir /rootfs/etc \
      && echo 'nogroup:*:10000:nobody' > /rootfs/etc/group \
      && echo 'nobody:*:10000:10000:::' > /rootfs/etc/passwd

FROM scratch
COPY --from=build --chown=10000:10000 /rootfs /
USER 10000:10000
EXPOSE 9116/tcp
ENTRYPOINT ["/bin/snmp_exporter"]
