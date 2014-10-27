source 'https://api.berkshelf.com'

# The apt cookbook is required to bring the apt cache up-to-date on Ubuntu
# systems, since the cache can become stale on older boxes.
cookbook 'apt', '~> 2.0'

cookbook 'omnibus', '~> 2.4.12'

# Dependency for building Varnish 4
cookbook 'python-docutils', :github => 'NREL-cookbooks/python-docutils'

# To setup internal SSH keys for internal Capistrano deployments.
cookbook 'vagrant_extras', :github => 'NREL-cookbooks/vagrant_extras'

# To automate the omnibus build process for our packages during the kitchen
# converge.
cookbook 'api-umbrella', :github => 'NREL-cookbooks/api-umbrella'

# Additional cookbooks for running tests after install has finished.
cookbook 'mongodb', :github => 'NREL-cookbooks/mongodb', :branch => "rhel7"
cookbook 'phantomjs', '~> 1.0.3'
