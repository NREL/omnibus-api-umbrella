name "varnish"
default_version "3.0.5"

dependency "pcre"
dependency "readline"
dependency "zlib"

source :url => "http://repo.varnish-cache.org/source/varnish-#{version}.tar.gz",
       :md5 => "674d44775cc927aee4601edb37f60198"

relative_path "varnish-#{version}"

env = {
  "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}",
  "PCRE_LIBS" => "-L#{install_dir}/embedded/lib -lpcre",
  "PCRE_CFLAGS" => "-I#{install_dir}/embedded/include",
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
}

build do
  command "./configure --prefix=#{install_dir}/embedded", :env => env
  command "make", :env => env
  command "make install"
end
