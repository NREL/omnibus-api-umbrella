name "nginx_lua"
default_version "v0.9.12"

dependency "luajit"
dependency "nginx_devel_kit"

source :git => "https://github.com/openresty/lua-nginx-module.git"

relative_path "#{name}-#{version}"

build do
  versioned_path = File.join(source_dir, relative_path)
  unversioned_path = File.join(source_dir, name)

  command "rm -rf #{unversioned_path}"
  command "ln -s #{versioned_path} #{unversioned_path}"
end
