source 'https://api.berkshelf.com'

# The apt cookbook is required to bring the apt cache up-to-date on Ubuntu
# systems, since the cache can become stale on older boxes.
cookbook 'apt', '~> 2.0'

cookbook 'omnibus', '~> 2.3.0'

cookbook 'golang', '~> 1.4.0'

# Dependency for building Varnish 4
cookbook 'python-docutils', :github => 'NREL-cookbooks/python-docutils'

# Dependency for building Apache Traffic Server
cookbook 'boost', '~> 0.2.0'

# To setup internal SSH keys for internal Capistrano deployments.
cookbook 'vagrant_extras', :github => 'NREL-cookbooks/vagrant_extras'
