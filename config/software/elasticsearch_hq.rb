name "elasticsearch_hq"
default_version "master"

dependency "elasticsearch"

env = with_embedded_path.merge({
  "JAVA_HOME" => "#{install_dir}/embedded/jre"
})

build do
  command "#{install_dir}/embedded/bin/plugin --install royrusso/elasticsearch-HQ/#{version}", :env => env
end
