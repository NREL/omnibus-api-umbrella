#!/usr/bin/env bats

@test "api-umbrella-gatekeeper internal test suite passes" {
  # Re-run npm install to fetch development/test dependencies (since they
  # aren't included in the built version), and then run the test suite.
  sudo -u api-umbrella-deploy bash -l -c 'export PATH=/opt/api-umbrella/embedded/bin:/usr/local/bin:$PATH && \
    cd /opt/api-umbrella/embedded/apps/router/current/node_modules/api-umbrella-gatekeeper && \
    npm install && \
    ./node_modules/.bin/grunt'
}
