FROM golang:1-alpine AS build

ARG VERSION="0.26.0"
ARG CHECKSUM="7405e8f608ec2b9195d89dacc8c9dad5eccb69936cd078bd918c75a230afed47"

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
