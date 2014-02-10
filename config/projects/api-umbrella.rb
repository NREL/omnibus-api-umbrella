name "api-umbrella"
maintainer "National Renewable Energy Laboratory"
homepage "http://github.com/NREL/api-umbrella"

replaces        "api-umbrella"
install_path    "/opt/api-umbrella"
build_version   Omnibus::BuildVersion.new.semver
build_iteration 1

# creates required build directories
dependency "preparation"

# api-umbrella dependencies/components
dependency "elasticsearch"
dependency "logrotate"
dependency "mongodb"
dependency "nginx"
dependency "nodejs"
dependency "redis"
dependency "ruby"
dependency "supervisor"
dependency "varnish"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
