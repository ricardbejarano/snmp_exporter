FROM alpine:3 AS build

ARG VERSION="0.16.1"
ARG CHECKSUM="7de711be5f73f2fe11b450bd8caade9e20aa802a0c64a73651035065bf049ef5"

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
