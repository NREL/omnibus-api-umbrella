name "api-umbrella-router"
default_version "config"

source :git => "https://github.com/NREL/api-umbrella-router.git"
relative_path "api-umbrella-router"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  command "bundle install --binstubs --path=./tmp-bundle", :env => env
  command "rm -rf #{install_dir}/embedded/apps/router", :env => env
  command "bundle exec cap omnibus deploy", :env => env
  command "ln -s #{install_dir}/embedded/apps/router/current/bin/api-umbrella-ctl #{install_dir}/bin/api-umbrella-ctl", :env => env
end
