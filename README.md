<p align="center"><img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/198/fire-extinguisher_1f9ef.png" width="120px"></p>
<h1 align="center">snmp_exporter (container image)</h1>
<p align="center">Built-from-source container image of <a href="https://prometheus.io/">Prometheus</a>' <a href="https://github.com/prometheus/snmp_exporter">SNMP exporter</a></p>


## Tags

### Docker Hub

Available on Docker Hub as [`docker.io/ricardbejarano/snmp_exporter`](https://hub.docker.com/r/ricardbejarano/snmp_exporter):

- [`0.20.0`, `latest` *(Dockerfile)*](Dockerfile)

### RedHat Quay

Available on RedHat Quay as [`quay.io/ricardbejarano/snmp_exporter`](https://quay.io/repository/ricardbejarano/snmp_exporter):

- [`0.20.0`, `latest` *(Dockerfile)*](Dockerfile)


## Features

* Compiled from source during build time
* Built `FROM scratch`, with zero bloat
* Statically linked to the [`musl`](https://musl.libc.org/) implementation of the C standard library
* Reduced attack surface (no shell, no UNIX tools, no package manager...)
* Runs as unprivileged (non-`root`) user


## Building

```bash
docker build --tag ricardbejarano/snmp_exporter --file Dockerfile .
```


## Configuration

### Volumes

- Mount your **configuration** at `/snmp.yml`.


## License

MIT licensed, see [LICENSE](LICENSE) for more details.
