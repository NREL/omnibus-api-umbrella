name "nginx_headers_more"
default_version "v0.25"

source :git => "https://github.com/openresty/headers-more-nginx-module.git"

relative_path "#{name}-#{version}"

build do
  versioned_path = File.join(source_dir, relative_path)
  unversioned_path = File.join(source_dir, name)

  command "rm -rf #{unversioned_path}"
  command "ln -s #{versioned_path} #{unversioned_path}"
end
