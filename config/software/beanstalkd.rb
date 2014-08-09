name "beanstalkd"
default_version "1.10"

version "1.9" do
  source :md5 => "37dd1bc580c77745c26239033f910ec5"
end

version "1.10" do
  source :md5 => "0994d83b03bde8264a555ea63eed7524"
end

source :url => "https://github.com/kr/beanstalkd/archive/v#{version}.tar.gz"

relative_path "beanstalkd-#{version}"

build do
  command "make"
  command "cp ./beanstalkd #{install_dir}/embedded/bin/"
end
