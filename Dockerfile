FROM debian AS build

ARG EXPORTER_VERSION="0.15.0"
ARG EXPORTER_CHECKSUM="c5e8e58a8187e9d0bd41dbeb7e09a15f5a59626821fa801dd99828d9cdd7efe9"

ADD https://github.com/prometheus/snmp_exporter/releases/download/v$EXPORTER_VERSION/snmp_exporter-$EXPORTER_VERSION.linux-amd64.tar.gz /tmp/snmp_exporter.tar.gz

RUN [ "$EXPORTER_CHECKSUM" = "$(sha256sum /tmp/snmp_exporter.tar.gz | awk '{print $1}')" ] && \
    tar -C /tmp -xf /tmp/snmp_exporter.tar.gz && \
    mv /tmp/snmp_exporter-$EXPORTER_VERSION.linux-amd64 /tmp/snmp_exporter


FROM scratch

COPY --from=build /tmp/snmp_exporter/snmp.yml /etc/snmp/
COPY --from=build /tmp/snmp_exporter/snmp_exporter /

COPY rootfs /

USER snmp:snmp
EXPOSE 9116/tcp
ENTRYPOINT ["/snmp_exporter"]
CMD ["--config.file=/etc/snmp/snmp.yml"]
