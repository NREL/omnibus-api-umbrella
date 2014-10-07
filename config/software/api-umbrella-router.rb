name "api-umbrella-router"
default_version "master"

source :git => "https://github.com/NREL/api-umbrella-router.git"
relative_path "api-umbrella-router"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  # "Deploy" the app to the local omnibus environment (localhost).
  command "rm -rf #{install_dir}/embedded/apps/router", :env => env
  command "bundle install --binstubs --path=#{install_dir}/embedded/apps/router/shared/bundle", :env => env
  command "bundle exec cap omnibus deploy", :env => env

  # Perform the bundle install again, but without development, test, or asset
  # dependencies (to keep the omnibus install lighter).
  command "bundle install --binstubs #{install_dir}/embedded/apps/router/shared/bin --path #{install_dir}/embedded/apps/router/shared/bundle --without development test assets --deployment --quiet --no-cache --clean", :env => env
  command "find #{install_dir}/embedded/apps/router/shared/bundle -wholename '*/cache/*.gem' -exec rm {} \\;"

  # Install the main api umbrella binary that comes from the router.
  command "ln -s #{install_dir}/embedded/apps/router/current/bin/api-umbrella #{install_dir}/bin/api-umbrella", :env => env

  # Create global directories and files
  command "sudo rm -rf /etc/api-umbrella /etc/init.d/api-umbrella"
  command "sudo mkdir /etc/api-umbrella"
  command "sudo chown #{ENV["USER"]} /etc/api-umbrella"
  command "sudo touch /etc/init.d/api-umbrella"
  command "sudo chown #{ENV["USER"]} /etc/init.d/api-umbrella"

  erb :source => "etc/init.d/api-umbrella.erb",
      :dest => "/etc/init.d/api-umbrella",
      :mode => 0755

  erb :source => "etc/api-umbrella/api-umbrella.yml.erb",
      :dest => "/etc/api-umbrella/api-umbrella.yml",
      :mode => 0644
end
