
name 'api-umbrella'
maintainer 'National Renewable Energy Laboratory'
homepage 'http://github.com/NREL/api-umbrella'

install_path    '/opt/api-umbrella'
build_version   Omnibus::BuildVersion.semver
build_iteration 1

override :beanstalkd, version: '1.10'
override :bundler, version: '1.6.5'
override :elasticsearch, version: '1.3.1'
override :luajit, version: '2.0.3'
override :mongodb, version: '2.6.4'
override :nginx, version: '1.7.4'
override :nginx_echo, version: 'v0.54'
override :nginx_headers_more, version: 'v0.25'
override :nginx_devel_kit, version: 'v0.2.19'
override :nginx_lua, version: 'v0.9.10'
override :nodejs, version: '0.10.30'
override :openssl, version: '1.0.1i'
override :python, version: '2.7.7'
override :redis, version: '2.8.13'
override :ruby, version: '2.1.2'
override :rubygems, version: '2.4.1'
override :serf, version: '0.6.3'
override :supervisor, version: '3.1.1'
override :trafficserver, version: '5.0.1'
override :varnish, version: '4.0.1'

# creates required build directories
dependency 'preparation'

# api-umbrella dependencies/components
dependency 'bundler'
dependency 'elasticsearch'
dependency 'logrotate'
dependency 'mongodb'
dependency 'nginx'
dependency 'nodejs'
dependency 'redis'
dependency 'ruby'
dependency 'rubygems'
dependency 'supervisor'
dependency 'varnish'

# version manifest file
dependency 'version-manifest'

exclude '\.git*'
exclude 'bundler\/git'
