name "nginx_lua"
default_version "v0.9.12"

dependency "luajit"
dependency "nginx_devel_kit"

source :git => "https://github.com/openresty/lua-nginx-module.git"

relative_path "#{name}-#{version}"
