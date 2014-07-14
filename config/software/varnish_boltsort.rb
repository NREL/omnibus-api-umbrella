name "varnish_boltsort"
default_version "b4f9e5b594ca5e78349ec6080442e8fac823ab65"

source :git => "https://github.com/vimeo/libvmod-boltsort.git"

relative_path "#{name}-#{version}"

env = {
  "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}",
  "VARNISHSRC" => "--add-module=#{source_dir}/varnish-4.0.1",
}

build do
  command "./autogen.sh", :env => env
  command "./configure --prefix=#{install_dir}/embedded", :env => env
  command "make", :env => env
  command "make install"
end
