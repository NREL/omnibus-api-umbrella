name "luajit"
default_version "2.0.3"

version "2.0.3" do
  source md5: "f14e9104be513913810cd59c8c658dc0"
end

source :url => "http://luajit.org/download/LuaJIT-#{version}.tar.gz"

relative_path "LuaJIT-#{version}"

build do
  command "make PREFIX=#{install_dir}/embedded"
  command "make install PREFIX=#{install_dir}/embedded"
end
