# Postgres Log Exporter

The Postgres databases operated by [Spilo](https://github.com/zalando/spilo)
write logs to CSV files inside the container. This log exporter container deploys
[`fluentd`](https://www.fluentd.org/) as a sidecar container to monitor the
Postgres log files and export all log events as JSON on `stdout`. From here,
the regular cluster log stack can pickup the log events for further processing.

## Credits and Further Reading

- The `fluentd` [Docker image description](https://hub.docker.com/r/fluent/fluentd/)
- The [`fluent-plugin-postgresql-csvlog` project](https://gitlab.com/gitlab-org/fluent-plugins/fluent-plugin-postgresql-csvlog)

