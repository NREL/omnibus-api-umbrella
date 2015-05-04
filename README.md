# API Umbrella Omnibus Packaging

This project creates package installers for [API Umbrella](https://github.com/NREL/api-umbrella). Since API Umbrella depends on specific versions of a number of other open source components, this packages all of the dependencies into a single API Umbrella installer. To find the current packages, see the [downloads](http://apiumbrella.io/download/).

Issues for this project are [maintained here](https://github.com/NREL/api-umbrella/issues).  

## Build Targets

We currently target 64bit installers for the following platforms:

- Ubuntu 12.04
- Ubuntu 14.04
- Debian 7
- Enterprise Linux 6 (CentOS/RedHat/Oracle/Scientific Linux)
- Enterprise Linux 7 (CentOS/RedHat/Oracle/Scientific Linux)

Other platforms can likely be targeted based on demand.

## Usage

To build new binary packages, first ensure you have a sane Ruby 1.9+ environment with bundler and the required gems installed:

```shell
$ bundle install --binstubs
```

Next, to build packages for all of the supported platforms, run:

```shell
$ ./bin/rake build
```

That script will ask a few questions to guide you through the process of building new binary packages. Either VirtualBox or AWS EC2 instances can be picked to perform the builds on.

The build process consists of:

- Building the new packages on each platform.
  - [Omnibus](https://github.com/chef/omnibus) is used to perform these builds and packaging using the configuration found in the [`config`](https://github.com/NREL/omnibus-api-umbrella/tree/master/config) directory.
- Testing each package by spinning up a brand new VM, installing the new package on it, and running some high-level sanity checks to ensure the packaging and installation is operating properly.
  - The package tests can be found in the [`test/integration/test_package`](https://github.com/NREL/omnibus-api-umbrella/tree/master/test/integration/test_package) directory.
- Testing all the internal API Umbrella components by spinning up a brand new VM, installing the new package on it, and running the internal test suite from each API Umbrella component.
  - The test scripts can be found in the [`test/integration/test_internal_components`](https://github.com/NREL/omnibus-api-umbrella/tree/master/test/integration/test_internal_components) directory.
