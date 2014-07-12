#
# Copyright:: Copyright (c) 2013-2014 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "python"
default_version "2.7.8"

dependency "expat"
dependency "gdbm"
dependency "ncurses"
dependency "zlib"
dependency "openssl"
dependency "readline"
dependency "bzip2"

version "2.7.7" do
  source :md5 => "cf842800b67841d64e7fb3cd8acb5663"
end

version "2.7.8" do
  source :md5 => "d4bca0159acb0b44a781292b5231936f"
end

source :url => "http://python.org/ftp/python/#{version}/Python-#{version}.tgz"

relative_path "Python-#{version}"

env = {
  "CFLAGS" => "-I#{install_dir}/embedded/include -I#{install_dir}/embedded/include/readline -O3 -g -pipe",
  "LDFLAGS" => "-Wl,-rpath,#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib",
  "PYTHON_DISABLE_MODULES" => "_bsddb",
}

build do
  patch :source => 'disable_modules.patch'
  command ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--enable-shared",
           "--with-system-expat",
           "--with-dbmliborder=gdbm"].join(" "), :env => env
  command "make", :env => env
  command "make install", :env => env
  command "rm -rf #{install_dir}/embedded/lib/python2.7/test"
end
