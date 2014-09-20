
name 'api-umbrella'
maintainer 'National Renewable Energy Laboratory'
homepage 'http://github.com/NREL/api-umbrella'

install_path    '/opt/api-umbrella'
build_version   '0.6.0'
build_iteration 1

override :beanstalkd, version: '1.10'
override :bundler, version: '1.7.3'
override :elasticsearch, version: '1.3.2'
override :elasticsearch_bigdesk, version: 'v2.5.0'
override :elasticsearch_head, version: 'b932aaaa23694c3a130836154f149c8c0e454b42'
override :elasticsearch_hq, version: '14ac1972fbf8a5f603e80bae8abc4fa46b692794'
override :luajit, version: '2.0.3'
override :mongodb, version: '2.6.4'
override :nginx, version: '1.7.5'
override :nginx_echo, version: 'v0.56'
override :nginx_headers_more, version: 'v0.25'
override :nginx_devel_kit, version: 'v0.2.19'
override :nginx_lua, version: '0c4528e50dc45de322a6ae86b1fff544d777e722'
override :nginx_txid, version: 'e7df6b153f394bb2d95dbe368d1b86eb7a85ad4f'
override :nodejs, version: '0.10.32'
override :openssl, version: '1.0.1i'
override :python, version: '2.7.7'
override :redis, version: '2.8.17'
override :ruby, version: '2.1.3'
override :rubygems, version: '2.4.1'
override :serf, version: '0.6.3'
override :supervisor, version: '3.1.2'
override :supervisor_mrlaforge, version: '0.6'
override :supervisor_serialrestart, version: '0.1.1'
override :trafficserver, version: '5.0.1'
override :varnish, version: '4.0.1'

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
dependency 'varnish'

dependency 'api-umbrella-router'
dependency 'api-umbrella-static-site'
dependency 'api-umbrella-web'

# version manifest file
dependency 'version-manifest'

exclude '\.git*'
exclude 'bundler\/git'
