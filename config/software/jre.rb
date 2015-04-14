#
# Copyright:: Copyright (c) 2012-2014 Chef Software, Inc.
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

name "jre"
default_version "7u75-b13"

whitelist_file "jre/bin/javaws"
whitelist_file "jre/bin/policytool"
whitelist_file "jre/lib"
whitelist_file "jre/plugin"

version_parts = version.match(/((\d+)u(\d+))-b(\d+)/)
version_with_update = version_parts[1]
version_major = version_parts[2]
version_update = version_parts[3]
version_build = version_parts[4]

if Ohai['kernel']['machine'] =~ /x86_64/
  # TODO: download x86 version on x86 machines
  source :url => "http://download.oracle.com/otn-pub/java/jdk/#{version}/jre-#{version_with_update}-linux-x64.tar.gz",
         :md5 => "1869f0d2dac96372e3c345105543ba3e",
         :cookie => "s_cc=true;oraclelicense=accept-securebackup-cookie;gpw_e24=http://www.oracle.com/technetwork/java/javase/downloads/jre#{version_major}-downloads-1880261.html;",
         :warning => "By including the JRE, you accept the terms of the Oracle Binary Code License Agreement for the Java SE Platform Products and JavaFX, which can be found at http://www.oracle.com/technetwork/java/javase/terms/license/index.html"
else
  source :url => "http://download.oracle.com/otn-pub/java/jdk/#{version}/jre-#{version_with_update}-linux-i586.tar.gz",
         :md5 => "3a2a94b9cd76fa1323dd9a5aaf48383b",
         :cookie => "s_cc=true;oraclelicense=accept-securebackup-cookie;gpw_e24=http://www.oracle.com/technetwork/java/javase/downloads/jre#{version_major}7-downloads-1880261.html;",
         :warning => "By including the JRE, you accept the terms of the Oracle Binary Code License Agreement for the Java SE Platform Products and JavaFX, which can be found at http://www.oracle.com/technetwork/java/javase/terms/license/index.html"
end

relative_path "jre1.#{version_major}.0_#{version_update}"

jre_dir = "#{install_dir}/embedded/jre"

build do
  command "mkdir -p #{jre_dir}"
  command "rsync -a . #{jre_dir}/"
end
