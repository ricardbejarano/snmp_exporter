FROM alpine:3 AS build

ARG VERSION="0.17.0"
ARG CHECKSUM="9617be4d1ebd15a25805a7374556ba7e0d7b0a2c37a9975b15c16aeed0c5fed5"

ADD https://github.com/prometheus/snmp_exporter/releases/download/v$VERSION/snmp_exporter-$VERSION.linux-amd64.tar.gz /tmp/snmp_exporter.tar.gz

RUN [ "$CHECKSUM" = "$(sha256sum /tmp/snmp_exporter.tar.gz | awk '{print $1}')" ] && \
    tar -C /tmp -xf /tmp/snmp_exporter.tar.gz && \
    mv /tmp/snmp_exporter-$VERSION.linux-amd64 /tmp/snmp_exporter

RUN echo "nogroup:*:100:nobody" > /tmp/group && \
    echo "nobody:*:100:100:::" > /tmp/passwd


FROM scratch

COPY --from=build --chown=100:100 /tmp/snmp_exporter/snmp_exporter \
                                  /tmp/snmp_exporter/snmp.yml \
                                  /
COPY --from=build --chown=100:100 /tmp/group \
                                  /tmp/passwd \
                                  /etc/

USER 100:100
EXPOSE 9116/tcp
ENTRYPOINT ["/snmp_exporter"]
