FROM golang:1-alpine AS build

ARG VERSION="0.21.0"
ARG CHECKSUM="a6ed31a8fd723a8c7d2880fd21d93fd2c9ae24fa4fdeb3834e72dccd8a3e1fb3"

ADD https://github.com/prometheus/snmp_exporter/archive/v$VERSION.tar.gz /tmp/snmp_exporter.tar.gz

RUN [ "$(sha256sum /tmp/snmp_exporter.tar.gz | awk '{print $1}')" = "$CHECKSUM" ] && \
    apk add curl make && \
    tar -C /tmp -xf /tmp/snmp_exporter.tar.gz && \
    mkdir -p /go/src/github.com/prometheus && \
    mv /tmp/snmp_exporter-$VERSION /go/src/github.com/prometheus/snmp_exporter && \
    cd /go/src/github.com/prometheus/snmp_exporter && \
      make build

RUN mkdir -p /rootfs && \
      cp /go/src/github.com/prometheus/snmp_exporter/snmp.yml /rootfs/ && \
    mkdir -p /rootfs/bin && \
      cp /go/src/github.com/prometheus/snmp_exporter/snmp_exporter /rootfs/bin/ && \
    mkdir -p /rootfs/etc && \
      echo "nogroup:*:10000:nobody" > /rootfs/etc/group && \
      echo "nobody:*:10000:10000:::" > /rootfs/etc/passwd


FROM scratch

COPY --from=build --chown=10000:10000 /rootfs /

USER 10000:10000
EXPOSE 9116/tcp
ENTRYPOINT ["/bin/snmp_exporter"]
