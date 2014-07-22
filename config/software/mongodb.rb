name "mongodb"
default_version "2.6.3"

if Ohai['kernel']['machine'] =~ /x86_64/
  source :url => "http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-#{version}.tgz",
         :md5 => "9b3db9b6d889e6bc0d6e3bfe4316a85a"
  relative_path "mongodb-linux-x86_64-#{version}"
else
  source :url => "http://fastdl.mongodb.org/linux/mongodb-linux-i686-#{version}.tgz",
         :md5 => "a82ff1787472399178589df5d8d45c81"
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
