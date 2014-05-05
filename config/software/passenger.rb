name "passenger"
default_version "4.0.41"

dependency "curl"
dependency "openssl"
dependency "pcre"
dependency "ruby"
dependency "rubygems"
dependency "zlib"

env = { "GEM_HOME" => nil, "GEM_PATH" => nil }

build do
  gem "install passenger --no-rdoc --no-ri -v #{version}", :env => env
end
