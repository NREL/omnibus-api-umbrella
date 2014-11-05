name "nginx_upstream_jdomain"
default_version "de7892926b696377bf9b54228b5116372da6daee"

source :git => "https://github.com/wdaike/ngx_upstream_jdomain.git"

relative_path "#{name}-#{version}"

build do
  versioned_path = File.join(source_dir, relative_path)
  unversioned_path = File.join(source_dir, name)

  command "rm -rf #{unversioned_path}"
  command "ln -s #{versioned_path} #{unversioned_path}"
end
