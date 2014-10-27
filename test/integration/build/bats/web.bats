#!/usr/bin/env bats

@test "api-umbrella-web internal test suite passes" {
  sudo -u vagrant bash -l -c 'export PATH=/opt/api-umbrella/embedded/bin:$PATH && \
    cd /opt/api-umbrella/embedded/apps/web/current && \
    env && \
    bundle install --without development && \
    bundle exec rake'
}
