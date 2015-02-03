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

name "nodejs"
default_version "0.10.10"

version "0.10.10" do
  source :md5 => "a47a9141567dd591eec486db05b09e1c"
end

version "0.10.26" do
  source :md5 => "15e9018dadc63a2046f61eb13dfd7bd6"
end

version "0.10.28" do
  source :md5 => "87768be7065d2120e71619948ab4bb2d"
end

version "0.10.29" do
  source :md5 => "e14ea9f46f9beecdf4e9423fb626c70b"
end

version "0.10.30" do
  source :md5 => "bae597a31bf6d23da1c4217bfed611dc"
end

version "0.10.31" do
  source :md5 => "1b65fe749f8e542a56a71af2b8c3a74a"
end

version "0.10.32" do
  source :md5 => "f5fd3a03948ec5d12b49fdc7c49a5cac"
end

version "0.10.33" do
  source :md5 => "626ca8a4f8fec4df49c78ed53d46f1f7"
end

version "0.10.35" do
  source :md5 => "2c00d8cf243753996eecdc4f6e2a2d11"
end

version "0.10.36" do
  source :md5 => "4b3527b830f2dacaba01aececd509c6f"
end

source :url => "https://nodejs.org/dist/v#{version}/node-v#{version}.tar.gz"

relative_path "node-v#{version}"

# Ensure we run with Python 2.6 on Redhats < 6
if Ohai['platform_family'] == "rhel" && Ohai['platform_version'].to_f < 6
  python = 'python26'
else
  python = 'python'
end

build do
  command "#{python} ./configure --prefix=#{install_dir}/embedded"
  command "make -j #{max_build_jobs}"
  command "make install"
end
