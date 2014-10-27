#!/usr/bin/env bats

@test "api-umbrella-gatekeeper internal test suite passes" {
  sudo -u vagrant bash -l -c 'export PATH=/opt/api-umbrella/embedded/bin:$PATH && \
    cd /opt/api-umbrella/embedded/apps/router/current/node_modules/api-umbrella-gatekeeper && \
    npm install && \
    ./node_modules/.bin/grunt'
}
