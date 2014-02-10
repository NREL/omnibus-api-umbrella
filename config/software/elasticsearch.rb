name "elasticsearch"
version "0.90.11"

dependency "jre"
dependency "rsync"

whitelist_file %r{elasticsearch/lib/sigar/.*\.so}

source :url => "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-#{version}.tar.gz",
       :md5 => "ce0fb911de0e2eddbc7e3f4d4a96e266"

relative_path "elasticsearch-#{version}"

env = {
  "JAVA_HOME" => "#{install_dir}/embedded/jre"
}

build do
  command "#{install_dir}/embedded/bin/rsync -a . #{install_dir}/embedded/elasticsearch/"
end
