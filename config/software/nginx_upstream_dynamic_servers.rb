name "nginx_upstream_dynamic_servers"
default_version "ae6f30440f13cba2a16bf4d075dbf6be97805dc2"

source :git => "https://github.com/GUI/nginx-upstream-dyanmic-servers.git"

relative_path "#{name}-#{version}"

build do
  versioned_path = File.join(source_dir, relative_path)
  unversioned_path = File.join(source_dir, name)

  command "rm -rf #{unversioned_path}"
  command "ln -s #{versioned_path} #{unversioned_path}"
end
