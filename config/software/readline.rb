name "readline"
version "6.2"

source :url => "ftp://ftp.cwru.edu/pub/bash/readline-#{version}.tar.gz",
       :md5 => "67948acb2ca081f23359d0256e9a271c"

relative_path "readline-#{version}"

build do
  command "./configure --prefix=#{install_dir}/embedded"
  command "make"
  command "make install"
end
