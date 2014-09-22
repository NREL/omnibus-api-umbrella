name "api-umbrella-web"
default_version "master"

source :git => "https://github.com/NREL/api-umbrella-web.git"
relative_path "api-umbrella-web"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  # "Deploy" the app to the local omnibus environment (localhost).
  command "bundle install --binstubs --path=./tmp-bundle", :env => env
  command "rm -rf #{install_dir}/embedded/apps/web", :env => env
  command "bundle exec cap omnibus deploy", :env => env

  # Remove temp files generated during the deploy.
  command "rm -rf #{install_dir}/embedded/apps/web/shared/log/*", :env => env
  command "rm -rf #{install_dir}/embedded/apps/web/shared/tmp/cache/*", :env => env

  # Perform the bundle install again, but without development, test, or asset
  # dependencies (to keep the omnibus install lighter).
  command "rm -rf #{install_dir}/embedded/apps/web/shared/bundle/*", :env => env
  command "cd #{install_dir}/embedded/apps/web/current && bundle install --binstubs #{install_dir}/embedded/apps/web/shared/bin --path #{install_dir}/embedded/apps/web/shared/bundle --without development test assets --deployment --quiet --no-cache", :env => env
end
