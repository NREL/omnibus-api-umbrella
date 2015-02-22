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
default_version "1.7.4"

dependency "pcre"
dependency "openssl"
dependency "nginx_echo"
dependency "nginx_headers_more"
dependency "nginx_txid"

version "1.7.1" do
  source md5: '9659cbb26f226f6390b18ef991a79233'
end

version "1.7.2" do
  source md5: '68949a7a0bad4615e9b737fc4e6047f2'
end

version "1.7.3" do
  source md5: '2b7f37f86e0af9bbb109c4dc225c6247'
end

version "1.7.4" do
  source md5: 'bfc256cf72123601af56501b0a6a41f5'
end

version "1.7.5" do
  source md5: 'e65aad627acc1cbe26527339a5814d57'
end

version "1.7.6" do
  source md5: 'dd444e5333e0d324bec480e2ff67870a'
end

version "1.7.7" do
  source md5: '3beaa25fc87ff2a75ab1b46174dc5ebf'
end

version "1.7.9" do
  source md5: 'a4debbe0ce0dd12b9c8f520bc3b66355'
end

version "1.7.10" do
  source md5: '8e800ea5247630b0fcf31ba35cb3245d'
end

source :url => "http://nginx.org/download/nginx-#{version}.tar.gz"

relative_path "nginx-#{version}"

env = with_standard_compiler_flags(with_embedded_path)

build do
  command [
    # Use the versioned path when including nginx modules, so we can more
    # easily tell which versions of modules were compiled in when running
    # `nginx -V`.
    "export NGINX_MODULE_ECHO_VERSIONED_PATH=`readlink -n #{source_dir}/nginx_echo`",
    "export NGINX_MODULE_HEADERS_MORE_VERSIONED_PATH=`readlink -n #{source_dir}/nginx_headers_more`",
    "export NGINX_MODULE_TXID_VERSIONED_PATH=`readlink -n #{source_dir}/nginx_txid`",
    [
      "./configure",
      "--prefix=#{install_dir}/embedded",
      "--conf-path=#{install_dir}/embedded/etc/nginx/nginx.conf",
      "--pid-path=#{install_dir}/embedded/var/run/nginx.pid",
      "--lock-path=#{install_dir}/embedded/var/lock/subsys/nginx",
      "--error-log-path=stderr",
      "--http-log-path=#{install_dir}/embedded/var/log/nginx/access.log",
      "--http-client-body-temp-path=#{install_dir}/embedded/var/lib/nginx/tmp/client_body",
      "--http-proxy-temp-path=#{install_dir}/embedded/var/lib/nginx/tmp/proxy",
      "--http-fastcgi-temp-path=#{install_dir}/embedded/var/lib/nginx/tmp/fastcgi",
      "--http-uwsgi-temp-path=#{install_dir}/embedded/var/lib/nginx/tmp/uwsgi",
      "--http-scgi-temp-path=#{install_dir}/embedded/var/lib/nginx/tmp/scgi",
      "--with-http_ssl_module",
      "--with-http_stub_status_module",
      "--with-http_gzip_static_module",
      "--with-http_gunzip_module",
      "--with-http_realip_module",
      "--add-module=$NGINX_MODULE_ECHO_VERSIONED_PATH",
      "--add-module=$NGINX_MODULE_HEADERS_MORE_VERSIONED_PATH",
      "--add-module=$NGINX_MODULE_TXID_VERSIONED_PATH",
      "--with-ipv6",
      "--with-cc-opt=\"-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include\"",
      "--with-ld-opt=\"-L#{install_dir}/embedded/lib\"",
    ].join(" "),
  ].join(" && "), :env => env
  command "make -j #{max_build_jobs}", :env => env
  command "make install"
  command "mkdir -p #{install_dir}/var/lib/nginx/tmp"
end
