name 'api-umbrella'
maintainer 'National Renewable Energy Laboratory'
homepage 'http://github.com/NREL/api-umbrella'

install_path    '/opt/api-umbrella'
build_version do
  source :version, :from_dependency => "api_umbrella_router"
  output_format :semver
end
build_iteration 1

override :api_umbrella_router, version: '0.6.0'
override :api_umbrella_web, version: 'master'
override :beanstalkd, version: '1.10'
override :bundler, version: '1.7.4'
override :dnsmasq, version: '2.72'
override :elasticsearch, version: '1.3.4'
override :elasticsearch_bigdesk, version: 'v2.5.0'
override :elasticsearch_head, version: '0176c510270530a1dbdb1b8f47b8cf53a8ff67eb'
override :elasticsearch_hq, version: '603ae9ed1b63ad6ffd0f81fb8ebf9f4f820ea360'
override :luajit, version: '2.0.3'
override :mongodb, version: '2.6.5'
override :nginx, version: '1.7.7'
override :nginx_echo, version: 'v0.56'
override :nginx_headers_more, version: 'v0.25'
override :nginx_devel_kit, version: 'v0.2.19'
override :nginx_lua, version: 'bda5b97950a3edbafc407dc9b065a4252263d4aa'
override :nginx_txid, version: 'a41a7051b745cdd97f2e4193135c97b15a123053'
override :nginx_upstream_jdomain, version: 'de7892926b696377bf9b54228b5116372da6daee'
override :nodejs, version: '0.10.33'
override :openssl, version: '1.0.1j'
override :python, version: '2.7.7'
override :redis, version: '2.8.17'
override :ruby, version: '2.1.4'
override :rubygems, version: '2.4.2'
override :serf, version: '0.6.3'
override :supervisor, version: '3.1.3'
override :supervisor_mrlaforge, version: '0.6'
override :supervisor_serialrestart, version: '0.1.1'
override :unbound, version: '1.4.22'
override :varnish, version: '4.0.2'

# creates required build directories
dependency 'preparation'

# api-umbrella components
dependency 'api_umbrella_router'
dependency 'api_umbrella_static_site'
dependency 'api_umbrella_web'

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
