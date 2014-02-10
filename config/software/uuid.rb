name "uuid"
version "1.6.2"

source :url => "http://www.mirrorservice.org/sites/ftp.ossp.org/pkg/lib/uuid/uuid-#{version}.tar.gz",
       :md5 => "5db0d43a9022a6ebbbc25337ae28942f"

relative_path "uuid-#{version}"

build do
  command "./configure --prefix=#{install_dir}/embedded"
  command "make"
  command "make install"
end
