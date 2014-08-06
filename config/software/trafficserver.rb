name "trafficserver"
default_version "5.0.1"

dependency "curl"
dependency "expat"
dependency "libxml2"
dependency "openssl"
dependency "pcre"
dependency "tcl"

version "5.0.1" do
  source md5: "76d5d7fea7ab1e3e1a09169ad0941767"
end

source :url => "http://mirror.cogentco.com/pub/apache/trafficserver/trafficserver-#{version}.tar.bz2"

relative_path "trafficserver-#{version}"

env = with_standard_compiler_flags(with_embedded_path)

build do
  command "./configure --prefix=#{install_dir}/embedded", :env => env
  command "make", :env => env
  command "make install", :env => env
end
