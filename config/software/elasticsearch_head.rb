name "elasticsearch_head"
default_version "master"

dependency "elasticsearch"

env = with_embedded_path.merge({
  "JAVA_HOME" => "#{install_dir}/embedded/jre"
})

build do
  command "#{install_dir}/embedded/bin/plugin --install mobz/elasticsearch-head/#{version}", :env => env
end
