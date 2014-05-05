source 'https://rubygems.org'

# Use Berkshelf for resolving cookbook dependencies
gem 'berkshelf', '~> 3.0'

# Install omnibus software
gem 'omnibus', '~> 3.0'
gem 'omnibus-software', github: 'opscode/omnibus-software'

# Use Test Kitchen with Vagrant for convering the build environment
gem 'test-kitchen',    '~> 1.2'
#gem 'kitchen-vagrant', '~> 0.14'
# Use git version for now: https://github.com/opscode/omnibus-ruby/issues/142
gem 'kitchen-vagrant', :git => 'https://github.com/test-kitchen/kitchen-vagrant.git'
