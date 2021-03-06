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

version "2.6.6" do
  if(Ohai['kernel']['machine'] =~ /x86_64/)
    source :md5 => "0eef7cb40c52c754eee3c47a74dc837c"
  else
    source :md5 => "a4f17ecdc55d9e216cd6112bc9c6b669"
  end
end

version "2.6.7" do
  if(Ohai['kernel']['machine'] =~ /x86_64/)
    source :md5 => "d999313e7bbfcf814c845a7476246b77"
  else
    source :md5 => "87a57c05e428fe1ced619e63107140ff"
  end
end

version "2.6.9" do
  if(Ohai['kernel']['machine'] =~ /x86_64/)
    source :md5 => "df585cd1e6ec186be07288b394fd3925"
  else
    source :md5 => "a8e9a7f6fc006359bc29481e68451f57"
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
