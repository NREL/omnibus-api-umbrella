name "mongodb"
default_version "2.6.1"

if OHAI.kernel['machine'] =~ /x86_64/
  source :url => "http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-#{version}.tgz",
         :md5 => "d3e5505d95c67ba52206960995655ec7"
  relative_path "mongodb-linux-x86_64-#{version}"
else
  source :url => "http://fastdl.mongodb.org/linux/mongodb-linux-i686-#{version}.tgz",
         :md5 => "fb3c5fb843344c0a94f8de667f373629"
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
