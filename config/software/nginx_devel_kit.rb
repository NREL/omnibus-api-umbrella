name "nginx_devel_kit"
default_version "v0.2.19"

source :git => "https://github.com/simpl/ngx_devel_kit.git"

relative_path "#{name}-#{version}"

build do
  versioned_path = File.join(source_dir, relative_path)
  unversioned_path = File.join(source_dir, name)

  command "rm -rf #{unversioned_path}"
  command "ln -s #{versioned_path} #{unversioned_path}"
end
