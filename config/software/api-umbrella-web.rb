name "api-umbrella-web"
default_version "3.0.5"

dependency "rsync"

source :git => "https://github.com/NREL/api-umbrella-web.git"
relative_path "api-umbrella-web"

build do
  bundle "install --without development test --path=#{install_dir}/embedded/apps/api-umbrella-web/shared/vendor/bundle"
  command "bundle exec cap omnibus deploy"
  command "rm -rf #{install_dir}/embedded/apps/api-umbrella-web"
  command "#{install_dir}/embedded/bin/rsync -a --delete --exclude=.git* ./ #{install_dir}/embedded/apps/api-umbrella-web/releases/#{release}/"
end
