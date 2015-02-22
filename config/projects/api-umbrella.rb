name 'api-umbrella'
maintainer 'National Renewable Energy Laboratory'
homepage 'http://github.com/NREL/api-umbrella'

install_path    '/opt/api-umbrella'
build_version(ENV["API_UMBRELLA_VERSION"] || raise("API_UMBRELLA_VERSION environment variable must be set"))
build_iteration(ENV["API_UMBRELLA_ITERATION"] || 1)

override :api_umbrella_router, version: 'master'
override :api_umbrella_web, version: 'master'
override :beanstalkd, version: '1.10'
override :bundler, version: '1.7.13' # Hold at 1.7 due to current issues with 1.8 and rails-assets gems: https://github.com/rails-assets/rails-assets/issues/226
override :dnsmasq, version: '2.72'
override :elasticsearch, version: '1.4.4'
override :elasticsearch_bigdesk, version: 'v2.5.0'
override :elasticsearch_head, version: 'ff222903e2ff0ccdeb0a7ae2103f90319987cf32'
override :elasticsearch_hq, version: '603ae9ed1b63ad6ffd0f81fb8ebf9f4f820ea360'
override :mongodb, version: '2.6.7'
override :nginx, version: '1.7.10'
override :nginx_echo, version: 'v0.57'
override :nginx_headers_more, version: 'v0.25'
override :nginx_txid, version: 'f1c197cb9c42e364a87fbb28d5508e486592ca42'
override :nodejs, version: '0.10.36'
override :openssl, version: '1.0.1l'
override :python, version: '2.7.7'
override :redis, version: '2.8.19'
override :ruby, version: '2.1.5' # Hold at 2.1 as long as we're on Rails 3.2: https://github.com/rails/rails/pull/18160
override :rubygems, version: '2.4.6'
override :supervisor, version: '3.1.3'
override :supervisor_mrlaforge, version: '0.6'
override :supervisor_serialrestart, version: '0.1.1'
override :varnish, version: '4.0.3'

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
extra_package_file "/etc/sudoers.d/api-umbrella"
extra_package_file "/etc/api-umbrella/api-umbrella.yml"
config_file "/etc/api-umbrella/api-umbrella.yml"

exclude '\.git*'
exclude 'bundler\/git'
