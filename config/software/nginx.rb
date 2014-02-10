#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
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

name "nginx"
version "1.4.4"

dependency "pcre"
dependency "passenger"
dependency "nginx_echo"
dependency "nginx_headers_more"
dependency "nginx_x_rid_header"

source :url => "http://nginx.org/download/nginx-#{version}.tar.gz",
       :md5 => "5dfaba1cbeae9087f3949860a02caa9f"

relative_path "nginx-#{version}"

env = {
  "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",

  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
}

build do
  command ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--with-http_ssl_module",
           "--with-http_stub_status_module",
           "--with-http_gzip_static_module",
           "--with-http_realip_module",
           "--add-module=#{source_dir}/nginx_echo",
           "--add-module=#{source_dir}/nginx_headers_more",
           "--add-module=#{source_dir}/nginx_x_rid_header",
           "--add-module=#{install_dir}/embedded/lib/ruby/gems/1.9.1/gems/passenger-4.0.37/ext/nginx",
           "--with-ipv6",
           "--with-debug",
           "--with-ld-opt=\"-L#{install_dir}/embedded/lib -luuid\"",
           "--with-cc-opt=\"-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include\""].join(" "),
          :env => env
  command "make -j #{max_build_jobs}", :env => env
  command "make install"
end
