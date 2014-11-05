name "dnsmasq"
default_version "2.72"

version "2.72" do
  source :md5 => "cf82f81cf09ad3d47612985012240483"
end

source :url => "http://www.thekelleys.org.uk/dnsmasq/dnsmasq-#{version}.tar.gz"

relative_path "dnsmasq-#{version}"

env = with_standard_compiler_flags(with_embedded_path)

build do
  command "make install PREFIX=#{install_dir}/embedded", :env => env
end
