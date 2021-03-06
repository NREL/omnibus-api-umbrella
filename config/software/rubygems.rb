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

name "rubygems"
default_version "1.8.24"

dependency "ruby"

version "1.8.29" do
  source md5: "a57fec0af33e2e2e1dbb3a68f6cc7269"
end

version "1.8.24" do
  source md5: "3a555b9d579f6a1a1e110628f5110c6b"
end

version "2.2.1" do
  source md5: "1f0017af0ad3d3ed52665132f80e7443"
end

version "2.2.2" do
  source md5: "f297a3fa7b1f3b693a11183a31668b9b"
end

version "2.3.0" do
  source md5: "29e89c13f5aa710f7b24c04253359cb0"
end

version "2.4.1" do
  source md5: "7e39c31806bbf9268296d03bd97ce718"
end

version "2.4.2" do
  source md5: "cb99da45a813b55755cf9d0abc51d3f6"
end

version "2.4.4" do
  source md5: "440a89ad6a3b1b7a69b034233cc4658e"
end

version "2.4.5" do
  source md5: "5918319a439c33ac75fbbad7fd60749d"
end

version "2.4.6" do
  source md5: "5909df4829e5350ca431644322ea9e89"
end

source url: "http://production.cf.rubygems.org/rubygems/rubygems-#{version}.tgz"

relative_path "rubygems-#{version}"

build do
  ruby "setup.rb"
end
