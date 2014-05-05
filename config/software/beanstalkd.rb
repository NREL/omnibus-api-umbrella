name "beanstalkd"
default_version "1.9"

source :url => "https://github.com/kr/beanstalkd/archive/v1.9.tar.gz",
       :md5 => "37dd1bc580c77745c26239033f910ec5"

relative_path "beanstalkd-#{version}"

build do
  command "make"
  command "cp ./beanstalkd #{install_dir}/embedded/bin/"
end
