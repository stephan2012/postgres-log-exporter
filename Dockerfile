ARG BASE_IMAGE_NAME=fluent/fluentd
ARG BASE_IMAGE_TAG=v1.14.5-debian-1.0

FROM ${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG}

ARG http_proxy
ARG https_proxy
ARG no_proxy
ARG apt_proxy

ARG UBUNTU_MIRROR_URL

USER root

ENV LANG=C.UTF-8
SHELL ["/bin/bash", "-c"]

RUN set -e -x -o pipefail \
  && http_proxy=${apt_proxy:-${http_proxy}} apt-get update \
  && http_proxy=${apt_proxy:-${http_proxy}} apt-get install -y --no-install-recommends --no-install-suggests \
    build-essential \
    libpq-dev \
    postgresql-client \
    ruby-dev \
  && fluent-gem install fluent-plugin-postgresql-csvlog --no-document \
  && gem sources --clear-all \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    build-essential libpq-dev ruby-dev \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY ["fluent.conf", "/fluentd/etc/"]

USER fluent
