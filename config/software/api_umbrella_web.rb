name "api_umbrella_web"
default_version "master"

dependency "bundler"
dependency "ruby"
dependency "rubygems"

source :git => "https://github.com/NREL/api-umbrella-web.git"
relative_path "api-umbrella-web"

build do
  env = with_standard_compiler_flags(with_embedded_path).merge({
    # Force this app's bundling to happen with the API Umbrella version of
    # Ruby, rather than the system omnibus version.
    "GEM_PATH" => "/opt/api-umbrella/embedded/lib/ruby/gems/*",
    "RUBY_ROOT" => "",
    "RUBYLIB" => "",
  })

  app_path = File.join(install_dir, "embedded/apps/web")
  bundle_path = File.join(app_path, "shared/bundle")

  # "Deploy" the app to the local omnibus environment (localhost).
  command "rm -rf #{app_path}", :env => env
  command "bundle install --binstubs --path=#{bundle_path}", :env => env
  command "bundle exec cap omnibus deploy", :env => env

  # Perform the bundle install again, but without development, test, or asset
  # dependencies (to keep the omnibus install lighter).
  command "cd #{app_path}/current && bundle install --binstubs #{app_path}/shared/bin --path #{bundle_path} --without development test assets --deployment --quiet --no-cache --clean", :env => env
  command "find #{bundle_path} -wholename '*/cache/*.gem' -exec rm {} \\;"

  # Remove temp files generated during the deploy.
  command "rm -rf #{app_path}/shared/log/*", :env => env
  command "rm -rf #{app_path}/shared/tmp/cache/*", :env => env

  # Ensure empty "shared" directories (that are symlinked to) stick around when
  # rebuilding from omnibus's git cache.
  command "find #{app_path}/shared -type d -empty -exec touch {}/.gitkeep \\;", :env => env
end
