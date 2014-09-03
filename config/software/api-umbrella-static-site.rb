name "api-umbrella-static-site"
default_version "config"

source :git => "https://github.com/NREL/api-umbrella-static-site.git"
relative_path "api-umbrella-static-site"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  # "Deploy" the app to the local omnibus environment (localhost).
  command "bundle install --binstubs --path=./tmp-bundle", :env => env
  command "rm -rf #{install_dir}/embedded/apps/static-site", :env => env
  command "bundle exec cap omnibus deploy", :env => env

  # Perform the bundle install again, but without development, test, or asset
  # dependencies (to keep the omnibus install lighter).
  command "rm -rf #{install_dir}/embedded/apps/static-site/shared/bundle/*", :env => env
  command "cd #{install_dir}/embedded/apps/static-site/current && bundle install --binstubs #{install_dir}/embedded/apps/static-site/shared/bin --path #{install_dir}/embedded/apps/static-site/shared/bundle --without development test assets --deployment --quiet --no-cache", :env => env
end
