name "readline"
default_version "6.2"

dependency "ncurses"

source :url => "ftp://ftp.cwru.edu/pub/bash/readline-#{version}.tar.gz",
       :md5 => "67948acb2ca081f23359d0256e9a271c"

relative_path "readline-#{version}"

env = {
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LDFLAGS" => "-L#{install_dir}/embedded/lib"
}

build do
  patch :source => "shlib.patch"
  command "./configure --prefix=#{install_dir}/embedded --with-curses", :env => env
  command "make", :env => env
  command "make install", :env => env
end
