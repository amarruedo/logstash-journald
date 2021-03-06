# logstash-journald

Example Dockerfile for Logstash, with journald input. Docker image hosted at
[state/logstash-journald](https://registry.hub.docker.com/u/state/logstash-journald/).

This uses the [official Logstash
repo](https://registry.hub.docker.com/_/logstash/) as its base. Currently it
comes with version 1.5.2. It then installs the
[logstash-input-journald](https://github.com/stuart-warren/logstash-input-journald)
plugin and [logstash-output-loggly](https://github.com/logstash-plugins/logstash-output-loggly).

Note that the `logstash` process runs as `root`, so it can access the journal.

## Usage

Please follow the [Logstash
instructions](https://registry.hub.docker.com/_/logstash/). You'll need to mount
the `/var/log/journal` directory as a read-only volume:

```bash
docker run \
  --rm \
  -v /var/log/journal:/var/log/journal:ro \
  quay.io/amarruedo/logstash-journald \
  logstash -e 'input { journald { } } output { loggly { key => \"YOUR_LOGGLY_KEY\" tag => \"logstash\" host => \"logs-01.loggly.com\" proto => \"https\" } }'
```

See
[logstash-input-journald](https://github.com/stuart-warren/logstash-input-journald)
for input configuration. Note that the Docker image already sets `SINCEDB_DIR`
to `/var/lib/logstash-journald`. You can mount a host directory as this volume
in order to preserve the journal offset between restarts.

## Building

Use `make gem` to create a gem for the
[logstash-input-journald](https://github.com/stuart-warren/logstash-input-journald)
plugin. `make build` can create the Docker image, tagged with the Logstash
version and a commit ref. `make tags` then tags this image with just the
Logstash version. `make push` will push to
[state/logstash-journald](https://registry.hub.docker.com/u/state/logstash-journald/).
