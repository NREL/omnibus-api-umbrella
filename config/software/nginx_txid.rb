name "nginx_txid"
default_version "e7df6b153f394bb2d95dbe368d1b86eb7a85ad4f"

source :git => "https://github.com/streadway/ngx_txid.git"

relative_path "#{name}-#{version}"

build do
  versioned_path = File.join(source_dir, relative_path)
  unversioned_path = File.join(source_dir, name)

  command "rm -rf #{unversioned_path}"
  command "ln -s #{versioned_path} #{unversioned_path}"
end
