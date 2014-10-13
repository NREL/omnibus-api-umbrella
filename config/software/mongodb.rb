name "mongodb"
default_version "2.6.4"

version "2.6.4" do
  if(Ohai['kernel']['machine'] =~ /x86_64/)
    source :md5 => "484f07082803e21691ece39fa9e1292b"
  else
    source :md5 => "99baf442a3fa6bfa58f01a750155713f"
  end
end

version "2.6.5" do
  if(Ohai['kernel']['machine'] =~ /x86_64/)
    source :md5 => "933fb038082f6eeb8182964bd51880c1"
  else
    source :md5 => "08bbceac04b072f596a6f7593c1241ae"
  end
end

source :url => "http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-#{version}.tgz"

if(Ohai['kernel']['machine'] =~ /x86_64/)
  relative_path "mongodb-linux-x86_64-#{version}"
else
  relative_path "mongodb-linux-i686-#{version}"
end

build do
  command "cp ./bin/mongo #{install_dir}/embedded/bin/"
  command "cp ./bin/mongod #{install_dir}/embedded/bin/"
  command "cp ./bin/mongodump #{install_dir}/embedded/bin/"
  command "cp ./bin/mongoexport #{install_dir}/embedded/bin/"
  command "cp ./bin/mongoimport #{install_dir}/embedded/bin/"
  command "cp ./bin/mongooplog #{install_dir}/embedded/bin/"
  command "cp ./bin/mongorestore #{install_dir}/embedded/bin/"
  command "cp ./bin/mongostat #{install_dir}/embedded/bin/"
end
