name "elasticsearch"
default_version "1.2.2"

dependency "jre"

whitelist_file %r{elasticsearch/lib/sigar/.*\.so}
whitelist_file %r{elasticsearch/lib/sigar/.*\.dylib}

version "1.2.1" do
  source md5: '327fa4ab2a4239972c7ce53832e50c02'
end

version "1.2.2" do
  source md5: 'f8886a5282da9b5b2afa72ece99317be'
end

version "1.3.0" do
  source md5: '47c945afa6d0fa45a8eeaaffd65e3312'
end

version "1.3.1" do
  source md5: '30d2562977b71c14b9e94168839bab18'
end

version "1.3.2" do
  source md5: '195d9ee7a4b7c6d70f6b658710c23fbb'
end

version "1.3.3" do
  source md5: '38f0e54365f324b00bae6a8973a1dfe8'
end

version "1.3.4" do
  source md5: '4d718cc9db428486ab06e19fc098b196'
end

version "1.3.5" do
  source md5: '7a3581063908abe921ca5b4276c46eca'
end

version "1.4.1" do
  source md5: 'e0fdc0b7c64f56b353df32a96325ece8'
end

version "1.4.2" do
  source md5: '8766b54a2d9c5349acca19deb958c192'
end

version "1.4.4" do
  source md5: '1eb4a0098d4b3c63caf7946794660728'
end

version "1.5.1" do
  source md5: '897f5c820bda7317ca19ca790b99074e'
end

source :url => "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-#{version}.tar.gz"

relative_path "elasticsearch-#{version}"

build do
  command "rsync -a . #{install_dir}/embedded/elasticsearch/"
  command "ln -sf #{install_dir}/embedded/elasticsearch/bin/elasticsearch #{install_dir}/embedded/bin/elasticsearch"
  command "ln -sf #{install_dir}/embedded/elasticsearch/bin/plugin #{install_dir}/embedded/bin/plugin"
end
