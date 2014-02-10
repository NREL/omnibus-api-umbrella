name "passenger"
version "4.0.37"

dependency "curl"
dependency "openssl"
dependency "pcre"
dependency "rubygems"
dependency "zlib"

env = { "GEM_HOME" => nil, "GEM_PATH" => nil }

build do
  gem "install passenger --no-rdoc --no-ri -v #{version}", :env => env
end
