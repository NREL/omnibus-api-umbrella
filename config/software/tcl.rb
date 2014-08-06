name "tcl"
default_version "8.6.1"

version "8.6.1" do
  source md5: "aae4b701ee527c6e4e1a6f9c7399882e"
end

source :url => "http://softlayer-dal.dl.sourceforge.net/project/tcl/Tcl/#{version}/tcl#{version}-src.tar.gz"

relative_path "tcl#{version}/unix"

build do
  command "autoconf"
  command "./configure --prefix=#{install_dir}/embedded"
  command "make"
  command "make install"
end
