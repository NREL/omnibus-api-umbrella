name "mongodb"
default_version "2.4.10"

if OHAI.kernel['machine'] =~ /x86_64/
  source :url => "http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-#{version}.tgz",
         :md5 => "aa88938437f27b8e11f82e1cfb63b4e8"
  relative_path "mongodb-linux-x86_64-#{version}"
else
  source :url => "http://fastdl.mongodb.org/linux/mongodb-linux-i686-#{version}.tgz",
         :md5 => "7d8654315aaa3eec3a3ceeeebbc0741e"
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
