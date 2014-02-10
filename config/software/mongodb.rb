name "mongodb"
version "2.4.9"

dependency "rsync"

whitelist_file "bin/mongosniff"

if OHAI.kernel['machine'] =~ /x86_64/
  source :url => "http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-#{version}.tgz",
         :md5 => "8a82a96d09242e859e225e226e7f47fc"
  relative_path "mongodb-linux-x86_64-#{version}"
else
  source :url => "http://fastdl.mongodb.org/linux/mongodb-linux-i686-#{version}.tgz",
         :md5 => "33d4707a4dcb5c32b9c8a3be008d0580"
  relative_path "mongodb-linux-i686-#{version}"
end

build do
  command "#{install_dir}/embedded/bin/rsync -a ./bin/ #{install_dir}/embedded/bin/"
end
