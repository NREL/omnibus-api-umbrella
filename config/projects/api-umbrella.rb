
name 'api-umbrella'
maintainer 'National Renewable Energy Laboratory'
homepage 'http://github.com/NREL/api-umbrella'

install_path    '/opt/api-umbrella'
build_version   Omnibus::BuildVersion.semver
build_iteration 1

override :beanstalkd, version: '1.9'
override :bundler, version: '1.6.5'
override :elasticsearch, version: '1.3.1'
override :mongodb, version: '2.6.3'
override :nginx, version: '1.7.3'
override :nodejs, version: '0.10.30'
override :python, version: '2.7.7'
override :redis, version: '2.8.13'
override :ruby, version: '2.1.2'
override :rubygems, version: '2.4.1'
override :serf, version: '0.6.3'
override :supervisor, version: '3.1.0'
override :varnish, version: '4.0.1'

# creates required build directories
dependency 'preparation'

# api-umbrella dependencies/components
dependency 'beanstalkd'
dependency 'bundler'
dependency 'elasticsearch'
dependency 'haproxy'
dependency 'logrotate'
dependency 'mongodb'
dependency 'nginx'
dependency 'nodejs'
dependency 'redis'
dependency 'ruby'
dependency 'rubygems'
dependency 'serf'
dependency 'supervisor'
dependency 'varnish'

# version manifest file
dependency 'version-manifest'

exclude '\.git*'
exclude 'bundler\/git'
