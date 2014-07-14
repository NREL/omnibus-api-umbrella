name "haproxy"
default_version "1.5.2"

dependency "pcre"
dependency "openssl"
dependency "zlib"

version "1.5.1" do
  source md5: '49640cf3ddd793a05fbd3394481a1ed4'
end

version "1.5.2" do
  source md5: 'e854fed32ea751d6db7f366cb910225a'
end

source :url => "http://www.haproxy.org/download/1.5/src/haproxy-#{version}.tar.gz"

relative_path "haproxy-#{version}"

env = {
  "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
}

options = [
  "TARGET=linux2628",
  "CPU=generic",
  "USE_PCRE=1",
  "USE_OPENSSL=1",
  "USE_ZLIB=1",
  "PREFIX=#{install_dir}/embedded",
]

build do
  command "make #{options.join(" ")}", :env => env
  command "make install #{options.join(" ")}"
end
