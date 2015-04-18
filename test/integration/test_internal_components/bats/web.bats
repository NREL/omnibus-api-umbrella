#!/usr/bin/env bats

@test "api-umbrella-web internal test suite passes" {
  # Re-run bundle install to fetch the test and asset dependencies (since they
  # aren't included in the built version), and then run the test suite.
  sudo -u api-umbrella-deploy bash -l -c 'export PATH=/opt/api-umbrella/embedded/bin:/usr/local/bin:$PATH && \
    cd /opt/api-umbrella/embedded/apps/web/current && \
    env && \
    bundle install --without development && \
    bundle exec rake'
}
