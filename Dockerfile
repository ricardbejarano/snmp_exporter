FROM alpine:3 AS build

ARG VERSION="0.18.0"
ARG CHECKSUM="11381ea4671e18f31a0c72a23c9383aa68948d4f7147f9b51693f6229383f749"

ADD https://github.com/prometheus/snmp_exporter/releases/download/v$VERSION/snmp_exporter-$VERSION.linux-amd64.tar.gz /tmp/snmp_exporter.tar.gz

RUN [ "$CHECKSUM" = "$(sha256sum /tmp/snmp_exporter.tar.gz | awk '{print $1}')" ] && \
    tar -C /tmp -xf /tmp/snmp_exporter.tar.gz

RUN mkdir -p /rootfs/etc && \
    cp \
      /tmp/snmp_exporter-$VERSION.linux-amd64/snmp_exporter \
      /tmp/snmp_exporter-$VERSION.linux-amd64/snmp.yml \
      /rootfs/ && \
    echo "nogroup:*:100:nobody" > /rootfs/etc/group && \
    echo "nobody:*:100:100:::" > /rootfs/etc/passwd


FROM scratch

COPY --from=build --chown=100:100 /rootfs /

USER 100:100
EXPOSE 9116/tcp
ENTRYPOINT ["/snmp_exporter"]
