
name 'api-umbrella'
maintainer 'National Renewable Energy Laboratory'
homepage 'http://github.com/NREL/api-umbrella'

install_path    '/opt/api-umbrella'
build_version   '0.6.0'
build_iteration 1

override :beanstalkd, version: '1.10'
override :bundler, version: '1.7.3'
override :elasticsearch, version: '1.3.4'
override :elasticsearch_bigdesk, version: 'v2.5.0'
override :elasticsearch_head, version: '0176c510270530a1dbdb1b8f47b8cf53a8ff67eb'
override :elasticsearch_hq, version: '603ae9ed1b63ad6ffd0f81fb8ebf9f4f820ea360'
override :luajit, version: '2.0.3'
override :mongodb, version: '2.6.5'
override :nginx, version: '1.7.6'
override :nginx_echo, version: 'v0.56'
override :nginx_headers_more, version: 'v0.25'
override :nginx_devel_kit, version: 'v0.2.19'
override :nginx_lua, version: '2fe0d8dda2c31ec35ed96664104061be20e60ce2'
override :nginx_txid, version: 'e7df6b153f394bb2d95dbe368d1b86eb7a85ad4f'
override :nodejs, version: '0.10.32'
override :openssl, version: '1.0.1i'
override :python, version: '2.7.7'
override :redis, version: '2.8.17'
override :ruby, version: '2.1.3'
override :rubygems, version: '2.4.2'
override :serf, version: '0.6.3'
override :supervisor, version: '3.1.2'
override :supervisor_mrlaforge, version: '0.6'
override :supervisor_serialrestart, version: '0.1.1'
override :varnish, version: '4.0.2'

# creates required build directories
dependency 'preparation'

# api-umbrella dependencies/components
dependency 'bundler'
dependency 'elasticsearch'
dependency 'elasticsearch_bigdesk'
dependency 'elasticsearch_head'
dependency 'elasticsearch_hq'
dependency 'logrotate'
dependency 'mongodb'
dependency 'nginx'
dependency 'nodejs'
dependency 'redis'
dependency 'ruby'
dependency 'rubygems'
dependency 'supervisor'
dependency 'supervisor_mrlaforge'
dependency 'supervisor_serialrestart'
dependency 'varnish'

dependency 'api-umbrella-router'
dependency 'api-umbrella-static-site'
dependency 'api-umbrella-web'

# version manifest file
dependency 'version-manifest'

# Place a package dependency on gcc, so it gets installed along with
# api-umbrella. This is required for Varnish to run and perform VCL compiling.
# Since gcc is a large dependency and we're not too picky about which version
# gets installed, that's why we're referencing that as an external dependency,
# rather than trying to bundle it inside the omnibus package.
runtime_dependency 'gcc'

extra_package_file "/etc/init.d/api-umbrella"
extra_package_file "/etc/logrotate.d/api-umbrella"
extra_package_file "/etc/api-umbrella/api-umbrella.yml"
config_file "/etc/api-umbrella/api-umbrella.yml"

exclude '\.git*'
exclude 'bundler\/git'
