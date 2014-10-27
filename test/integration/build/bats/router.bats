#!/usr/bin/env bats

@test "api-umbrella-router internal test suite passes" {
  sudo -u vagrant bash -l -c 'export PATH=/opt/api-umbrella/embedded/bin:$PATH && \
    cd /opt/api-umbrella/embedded/apps/router/current && \
    npm install && \
    ./node_modules/.bin/grunt'
}
