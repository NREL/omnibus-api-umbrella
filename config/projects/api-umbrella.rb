
name "api-umbrella"
maintainer "CHANGE ME"
homepage "CHANGEME.com"

replaces        "api-umbrella"
install_path    "/opt/api-umbrella"
build_version   Omnibus::BuildVersion.new.semver
build_iteration 1

# creates required build directories
dependency "preparation"

# api-umbrella dependencies/components
# dependency "somedep"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
