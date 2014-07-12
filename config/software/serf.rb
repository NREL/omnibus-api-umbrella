name "serf"
default_version "0.6.3"

os = OHAI['os']
arch = if(OHAI['kernel']['machine'] =~ /x86_64/) then "amd64" else "386" end
md5 = case(os)
      when "linux"
        case(arch)
        when "amd64"
          "7a603cc4b858c4f5ea70a8e8e8df7c83"
        when "386"
          "e02daaee4faa743af7bfa4f363e190cc"
        end
      end

source :url => "https://dl.bintray.com/mitchellh/serf/#{version}_#{os}_#{arch}.zip",
       :md5 => md5

relative_path "."

build do
  command "cp ./serf #{install_dir}/embedded/bin/"
end
