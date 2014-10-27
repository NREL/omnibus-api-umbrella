name "supervisor_mrlaforge"
default_version "0.6"

dependency "pip"
dependency "supervisor"

env = with_standard_compiler_flags(with_embedded_path)

build do
  command "#{install_dir}/embedded/bin/pip install -I --build #{project_dir} mr.laforge==#{version}", :env => env
end
