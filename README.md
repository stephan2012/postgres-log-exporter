# Postgres Log Exporter

The Postgres databases operated by
[Spilo](https://github.com/zalando/spilo) write logs to CSV files
inside the container. This log exporter runs
[`fluentd`](https://www.fluentd.org/) and is intended to be run as a
sidecar container that monitors the Postgres log files and exports all
log events as JSON on `stdout`. From here, the regular cluster log
stack can pickup the log events.

## Example Usage

Enable sidecars in the [Zalando Postgres
Operator](https://github.com/zalando/postgres-operator) configuration
and add the actual sidecar. E.g.,

```yaml
apiVersion: acid.zalan.do/v1
configuration:
  […]
  kubernetes:
    enable_sidecars: true
  sidecars:
  - env:
    - name: NODE_NAME
      valueFrom:
        fieldRef:
          fieldPath: spec.nodeName
    image: my.repository.com/postgres-log-exporter:v0.3.5
    name: log-exporter
    resources:
      limits:
        memory: 500Mi
      requests:
        cpu: 50m
        memory: 50Mi
  […]
```

## Credits and Further Reading

- The `fluentd` [Docker image description](https://hub.docker.com/r/fluent/fluentd/)
- The [`fluent-plugin-postgresql-csvlog` project](https://gitlab.com/gitlab-org/fluent-plugins/fluent-plugin-postgresql-csvlog)
