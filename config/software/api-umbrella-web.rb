name "api-umbrella-web"
default_version "master"

source :git => "https://github.com/NREL/api-umbrella-web.git"
relative_path "api-umbrella-web"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  app_path = File.join(install_dir, "embedded/apps/web")
  bundle_path = File.join(app_path, "shared/bundle")

  # "Deploy" the app to the local omnibus environment (localhost).
  command "rm -rf #{app_path}", :env => env
  command "bundle install --binstubs --path=#{bundle_path}", :env => env
  command "bundle exec cap omnibus deploy", :env => env

  # Remove temp files generated during the deploy.
  command "rm -rf #{app_path}/shared/log/*", :env => env
  command "rm -rf #{app_path}/shared/tmp/cache/*", :env => env

  # Perform the bundle install again, but without development, test, or asset
  # dependencies (to keep the omnibus install lighter).
  command "cd #{app_path}/current && bundle install --binstubs #{app_path}/shared/bin --path #{bundle_path} --without development test assets --deployment --quiet --no-cache --clean", :env => env
  command "find #{bundle_path} -wholename '*/cache/*.gem' -exec rm {} \\;"
end
