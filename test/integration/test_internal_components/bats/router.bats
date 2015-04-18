#!/usr/bin/env bats

@test "api-umbrella-router internal test suite passes" {
  # The router tests hit the web app in test mode, so ensure all of it's assets
  # and test dependencies are installed.
  sudo -u api-umbrella-deploy bash -l -c 'export PATH=/opt/api-umbrella/embedded/bin:/usr/local/bin:$PATH && \
    cd /opt/api-umbrella/embedded/apps/web/current && \
    bundle install --without development'

  # Re-run npm install to fetch development/test dependencies (since they
  # aren't included in the built version), and then run the test suite.
  sudo -u api-umbrella-deploy bash -l -c 'export PATH=/opt/api-umbrella/embedded/bin:/usr/local/bin:$PATH && \
    cd /opt/api-umbrella/embedded/apps/router/current && \
    npm install && \
    ./node_modules/.bin/grunt'
}
