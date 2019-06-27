<p align=center><img src=https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/198/fire-extinguisher_1f9ef.png width=120px></p>
<h1 align=center>snmp_exporter (container image)</h1>
<p align=center>The simplest container image of the official Prometheus <a href=https://github.com/prometheus/snmp_exporter>snmp_exporter</a></p>


## Tags

### Docker Hub

Available on [Docker Hub](https://hub.docker.com) as [`ricardbejarano/snmp_exporter`](https://hub.docker.com/r/ricardbejarano/snmp_exporter):

- [`0.15.0`, `master`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/snmp_exporter/blob/master/Dockerfile)

### Quay

Available on [Quay](https://quay.io) as [`quay.io/ricardbejarano/snmp_exporter`](https://quay.io/repository/ricardbejarano/snmp_exporter):

- [`0.15.0`, `master`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/snmp_exporter/blob/master/Dockerfile)


## Features

* Super tiny (`~14.0MB`)
* Binary pulled from official website
* Built `FROM scratch`, see [Filesystem](#filesystem) for an exhaustive list of the image's contents
* Reduced attack surface (no shell, no UNIX tools, no package manager...)


## Configuration

### Volumes

- Bind your **configuration** at `/etc/snmp/snmp.yml`.


## Building

```bash
docker build -t snmp_exporter .
```


## Filesystem

The images' contents are:

```
/
├── etc/
│   ├── group
│   ├── passwd
│   └── snmp/
│       └── snmp.yml
└── snmp_exporter
```


## License

See [LICENSE](https://github.com/ricardbejarano/snmp_exporter/blob/master/LICENSE).
