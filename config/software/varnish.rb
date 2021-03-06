name "varnish"
default_version "4.0.1"

dependency "ncurses"
dependency "pcre"
dependency "readline"
dependency "zlib"

version "4.0.1" do
  source :md5 => "53e272f448b2109ab370e03d794a243f"
end

version "4.0.2" do
  source :md5 => "bf86f3630605c273b1bbadbbe518237a"
end

version "4.0.3" do
  source :md5 => "16a683f2e41f7d80219cec5d4649380c"
end

source :url => "http://repo.varnish-cache.org/source/varnish-#{version}.tar.gz"

relative_path "varnish-#{version}"

env = with_standard_compiler_flags(with_embedded_path).merge({
  "PCRE_LIBS" => "-L#{install_dir}/embedded/lib -lpcre",
  "PCRE_CFLAGS" => "-I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
  "CURSES_LIB" => "-lncursesw -ltinfow",
})

build do
  command "./configure --prefix=#{install_dir}/embedded", :env => env
  command "make", :env => env
  command "make install"
end
