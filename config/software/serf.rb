name "serf"
default_version "0.6.1"

os = OHAI['os']
arch = if(OHAI['kernel']['machine'] =~ /x86_64/) then "amd64" else "386" end
md5 = case(os)
      when "linux"
        case(arch)
        when "amd64"
          "c395c52bd3af9b98b53a81bef52e8142"
        when "386"
          "23b6fe3c64613a33df36a2081d60ea16"
        end
      end

source :url => "https://dl.bintray.com/mitchellh/serf/#{version}_#{os}_#{arch}.zip",
       :md5 => md5

relative_path "."

build do
  command "cp ./serf #{install_dir}/embedded/bin/"
end
