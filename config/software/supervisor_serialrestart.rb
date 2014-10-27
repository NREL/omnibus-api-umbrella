name "supervisor_serialrestart"
default_version "0.1.1"

dependency "pip"
dependency "supervisor"

env = with_standard_compiler_flags(with_embedded_path)

build do
  command "#{install_dir}/embedded/bin/pip install -I --build #{project_dir} supervisor-serialrestart==#{version}", :env => env
end
