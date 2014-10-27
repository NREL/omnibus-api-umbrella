name "api_umbrella_router"
default_version "master"

dependency "bundler"
dependency "elasticsearch"
dependency "elasticsearch_bigdesk"
dependency "elasticsearch_head"
dependency "elasticsearch_hq"
dependency "mongodb"
dependency "nginx"
dependency "nodejs"
dependency "redis"
dependency "ruby"
dependency "rubygems"
dependency "supervisor"
dependency "supervisor_mrlaforge"
dependency "supervisor_serialrestart"
dependency "varnish"

source :git => "https://github.com/NREL/api-umbrella-router.git"
relative_path "api-umbrella-router"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  app_path = File.join(install_dir, "embedded/apps/router")
  bundle_path = File.join(install_dir, "shared/bundle")

  # "Deploy" the app to the local omnibus environment (localhost).
  command "rm -rf #{app_path}", :env => env
  command "bundle install --binstubs --path=#{bundle_path}", :env => env
  command "bundle exec cap omnibus deploy", :env => env

  # Perform the bundle install again, but without development, test, or asset
  # dependencies (to keep the omnibus install lighter).
  command "cd #{app_path}/current && bundle install --binstubs #{app_path}/shared/bin --path #{bundle_path} --without development test assets --deployment --quiet --no-cache --clean", :env => env
  command "find #{bundle_path} -wholename '*/cache/*.gem' -exec rm {} \\;"

  # Install the main api umbrella binary that comes from the router.
  command "ln -s #{app_path}/current/bin/api-umbrella #{install_dir}/bin/api-umbrella", :env => env

  # Ensure empty "shared" directories (that are symlinked to) stick around when
  # rebuilding from omnibus's git cache.
  command "find #{app_path}/shared -type d -empty -exec touch {}/.gitkeep \\;", :env => env

  # Create global directories and files
  # Note that the permission changes here are only so the build user can
  # install files to these locations on the system without sudo for the erb
  # commands (these permissions do not reflect the actual package install
  # permissions).
  command "sudo rm -rf /etc/api-umbrella /etc/init.d/api-umbrella"
  command "sudo mkdir /etc/api-umbrella"
  command "sudo chown #{ENV["USER"]} /etc/api-umbrella"
  command "sudo touch /etc/init.d/api-umbrella"
  command "sudo chown #{ENV["USER"]} /etc/init.d/api-umbrella"
  command "sudo touch /etc/logrotate.d/api-umbrella"
  command "sudo chown #{ENV["USER"]} /etc/logrotate.d/api-umbrella"

  erb :source => "etc/init.d/api-umbrella.erb",
      :dest => "/etc/init.d/api-umbrella",
      :mode => 0755

  erb :source => "etc/logrotate.d/api-umbrella.erb",
      :dest => "/etc/logrotate.d/api-umbrella",
      :mode => 0644

  erb :source => "etc/api-umbrella/api-umbrella.yml.erb",
      :dest => "/etc/api-umbrella/api-umbrella.yml",
      :mode => 0644
end
