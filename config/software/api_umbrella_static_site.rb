name "api_umbrella_static_site"
default_version "master"

dependency "bundler"
dependency "ruby"
dependency "rubygems"

source :git => "https://github.com/NREL/api-umbrella-static-site.git"
relative_path "api-umbrella-static-site"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  app_path = File.join(install_dir, "embedded/apps/static-site")
  bundle_path = File.join(app_path, "shared/bundle")

  # "Deploy" the app to the local omnibus environment (localhost).
  command "rm -rf #{app_path}", :env => env
  command "bundle install --binstubs --path=#{bundle_path}", :env => env
  command "bundle exec cap omnibus deploy", :env => env

  # Perform the bundle install again, but without development, test, or asset
  # dependencies (to keep the omnibus install lighter).
  command "cd #{app_path}/current && bundle install --binstubs #{app_path}/shared/bin --path #{bundle_path} --without development test assets --deployment --quiet --no-cache --clean", :env => env
  command "find #{bundle_path} -wholename '*/cache/*.gem' -exec rm {} \\;"

  # Ensure empty "shared" directories (that are symlinked to) stick around when
  # rebuilding from omnibus's git cache.
  command "find #{app_path}/shared -type d -empty -exec touch {}/.gitkeep \\;", :env => env
end
