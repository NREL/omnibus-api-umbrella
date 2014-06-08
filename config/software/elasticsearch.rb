name "elasticsearch"
default_version "1.2.1"

dependency "jre"
dependency "rsync"

whitelist_file %r{elasticsearch/lib/sigar/.*\.so}
whitelist_file %r{elasticsearch/lib/sigar/.*\.dylib}

source :url => "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-#{version}.tar.gz",
       :md5 => "327fa4ab2a4239972c7ce53832e50c02"

relative_path "elasticsearch-#{version}"

env = {
  "JAVA_HOME" => "#{install_dir}/embedded/jre"
}

build do
  command "#{install_dir}/embedded/bin/rsync -a . #{install_dir}/embedded/elasticsearch/"
  command "ln -sf #{install_dir}/embedded/elasticsearch/bin/elasticsearch #{install_dir}/embedded/bin/elasticsearch"
  command "ln -sf #{install_dir}/embedded/elasticsearch/bin/plugin #{install_dir}/embedded/bin/plugin"
end
