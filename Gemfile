source 'https://rubygems.org'

# Install omnibus software
gem 'omnibus', '~> 3.2.1'
gem 'omnibus-software', :github => 'opscode/omnibus-software', :branch => 'omnibus/3.2-stable'

# For the build rake task
gem 'rake', '~> 10.3.2'
gem 'highline', '~> 1.6.21'

# Omit installing other gems when running the build process inside a test
# kitchen instance. Since the build instances don't need berkshelf installed,
# this can save a lot of time (since the slow gecode dependnecy doesn't need to
# install and build).
group :host_machine do
  # Use Berkshelf for resolving cookbook dependencies
  gem 'berkshelf', '~> 3.1.5'

  # Use Test Kitchen with Vagrant for convering the build environment
  gem 'test-kitchen', '~> 1.2.1'
  gem 'kitchen-vagrant', '~> 0.15.0'

  # For checking for outdated version
  gem 'semverse', '~> 1.2.1'

  # Colorized console printing
  gem 'rainbow', '~> 2.0.0'
end
