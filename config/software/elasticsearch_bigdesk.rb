name "elasticsearch_bigdesk"
default_version "v2.5.0"

dependency "elasticsearch"

env = with_embedded_path.merge({
  "JAVA_HOME" => "#{install_dir}/embedded/jre"
})

build do
  command "#{install_dir}/embedded/bin/plugin --install lukas-vlcek/bigdesk/#{version}", :env => env
end
