name "serf"
default_version "0.5.0"

os = OHAI['os']
arch = if(OHAI['kernel']['machine'] =~ /x86_64/) then "amd64" else "386" end
md5 = case(os)
      when "linux"
        case(arch)
        when "amd64"
          "ecd5121bdeda0cedae98dba6433779ca"
        when "386"
          "606057d9569d17b41f845a6d0962726b"
        end
      end

source :url => "https://dl.bintray.com/mitchellh/serf/#{version}_#{os}_#{arch}.zip",
       :md5 => md5

relative_path "."

build do
  command "cp ./serf #{install_dir}/embedded/bin/"
end
