name "unbound"
default_version "1.4.22"

dependency "openssl"

version "1.4.22" do
  source :md5 => "59728c74fef8783f8bad1d7451eba97f"
end

source :url => "http://unbound.net/downloads/unbound-#{version}.tar.gz"

relative_path "unbound-#{version}"

env = with_standard_compiler_flags(with_embedded_path)

build do
  command "./configure --prefix=#{install_dir}/embedded", :env => env
  command "make", :env => env
  command "make install", :env => env
end
