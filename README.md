<p align="center"><img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/198/fire-extinguisher_1f9ef.png" width="120px"></p>
<h1 align="center">snmp_exporter (container image)</h1>
<p align="center">Minimal container image of Prometheus' <a href="https://github.com/prometheus/snmp_exporter">snmp_exporter</a></p>


## Tags

### Docker Hub

Available on [Docker Hub](https://hub.docker.com) as [`ricardbejarano/snmp_exporter`](https://hub.docker.com/r/ricardbejarano/snmp_exporter):

- [`0.16.1`, `master`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/snmp_exporter/blob/master/Dockerfile) (about `14MB`)
- [`0.16.1-armv7`, `master-armv7`, `latest-armv7` *(Dockerfile.armv7)*](https://github.com/ricardbejarano/snmp_exporter/blob/master/Dockerfile.armv7) (about `12.2MB`)

### Quay

Available on [Quay](https://quay.io) as:

- [`quay.io/ricardbejarano/snmp_exporter`](https://quay.io/repository/ricardbejarano/snmp_exporter), tags: [`0.16.1`, `master`, `latest` *(Dockerfile.glibc)*](https://github.com/ricardbejarano/snmp_exporter/blob/master/Dockerfile.glibc) (about `14MB`)
- [`quay.io/ricardbejarano/snmp_exporter-armv7`](https://quay.io/repository/ricardbejarano/snmp_exporter-armv7), tags: [`0.16.1`, `master`, `latest` *(Dockerfile.glibc-armv7)*](https://github.com/ricardbejarano/snmp_exporter/blob/master/Dockerfile.glibc-armv7) (about `12.2MB`)


## Features

* Super tiny (see [Tags](#tags))
* Binary pulled from official sources during build time
* Built `FROM scratch`, with zero bloat (see [Filesystem](#filesystem))
* Reduced attack surface (no shell, no UNIX tools, no package manager...)
* Runs as unprivileged (non-`root`) user


## Building

```bash
docker build -t snmp_exporter .
```


## Configuration

### Volumes

- Mount your **configuration** at `/snmp.yml`.


## Filesystem

```
/
├── etc
│   ├── group
│   └── passwd
├── snmp.yml
└── snmp_exporter
```


## License

See [LICENSE](https://github.com/ricardbejarano/snmp_exporter/blob/master/LICENSE).
