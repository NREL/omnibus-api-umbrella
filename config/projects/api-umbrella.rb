
name 'api-umbrella'
maintainer 'National Renewable Energy Laboratory'
homepage 'http://github.com/NREL/api-umbrella'

replaces        'api-umbrella'
install_path    '/opt/api-umbrella'
build_version   Omnibus::BuildVersion.new.semver
build_iteration 1

override :nodejs, version: '0.10.26'
override :ruby, version: '2.1.1'
override :rubygems, version: '2.2.2'

# creates required build directories
dependency 'preparation'

# api-umbrella dependencies/components
dependency 'beanstalkd'
dependency 'bundler'
dependency 'elasticsearch'
dependency 'logrotate'
dependency 'mongodb'
dependency 'nginx'
dependency 'nodejs'
dependency 'passenger'
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
