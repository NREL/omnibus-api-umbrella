name "pcc"
default_version "1.0.0"

source :url => "http://pcc.ludd.ltu.se/ftp/pub/pcc-releases/pcc-#{version}.tgz",
       :md5 => "6e5d851ee57fe58702fe4e80ecd1f852"

relative_path "pcc-#{version}"

env = with_standard_compiler_flags(with_embedded_path)

build do
  command "./configure --prefix=#{install_dir}/embedded ", :env => env
  command "make", :env => env
  command "make install"
end
