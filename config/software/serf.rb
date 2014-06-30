name "serf"
default_version "0.6.2"

os = OHAI['os']
arch = if(OHAI['kernel']['machine'] =~ /x86_64/) then "amd64" else "386" end
md5 = case(os)
      when "linux"
        case(arch)
        when "amd64"
          "b68f983777c222f18d870bb534904f9c"
        when "386"
          "422fe05c95809024f5ff16f9a1b19a52"
        end
      end

source :url => "https://dl.bintray.com/mitchellh/serf/#{version}_#{os}_#{arch}.zip",
       :md5 => md5

relative_path "."

build do
  command "cp ./serf #{install_dir}/embedded/bin/"
end
