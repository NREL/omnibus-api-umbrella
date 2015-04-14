task :build do
  require "highline/import"
  require "semverse"

  sh "bundle install --binstubs --quiet"

  instances = `bin/kitchen list --bare`.split("\n").sort
  if(instances.empty?)
    puts "No kitchen instances found"
    exit 1
  end

  instances.select! { |instance| instance =~ /^build-/ }
  instances.map! { |instance| instance.gsub!(/^build-/, "") }

  instances << "all"

  puts "\n\n"

  ENV["API_UMBRELLA_VERSION"] ||= ask("API Umbrella version number to build (eg, 0.3.0): ")
  ENV["API_UMBRELLA_ITERATION"] ||= "1"

  # Validate the version given.
  Semverse::Version.new(ENV["API_UMBRELLA_VERSION"])

  ENV["KITCHEN_DRIVER"] ||= choose("aws", "vagrant") do |menu|
    menu.prompt = "Choose where to build the packages: "
  end

  if(ENV["KITCHEN_DRIVER"] == "aws")
    ENV["AWS_ACCESS_KEY"] ||= ask("AWS Access Key ID: ")
    ENV["AWS_SECRET_KEY"] ||= ask("AWS Secret Access Key: ")
    ENV["AWS_SSH_KEY_ID"] ||= ask("AWS SSH Key Pair ID: ")
    ENV["AWS_SSH_KEY_PATH"] ||= ask("AWS SSH Key Pair Private Key Path: ")
    raise("AWS private key path doesn't exist (#{ENV["AWS_SSH_KEY_PATH"]})") unless(File.exists?(File.expand_path(ENV["AWS_SSH_KEY_PATH"])))
  end

  instance = choose(*instances) do |menu|
    menu.prompt = "Choose which instance to build: "
  end

  instance = "*" if(instance == "all")

  build_instance = "build-#{instance}"
  test_instance = "test-install-package-#{instance}"

  concurrency = 2
  if(ENV["KITCHEN_DRIVER"] == "aws")
    concurrency = instances.length
  end

  sh "bin/kitchen test -c #{concurrency} #{build_instance}"
  sh "bin/kitchen test -c #{concurrency} #{test_instance}"
end

# A task for trying to find outdated software versions based on what's being
# built versus what's available.
desc "Find outdated software dependencies"
task :outdated do
  require "semverse"
  require "rainbow"

  repos = {
    "api_umbrella_router" => {
      :git => "https://github.com/NREL/api-umbrella-router.git",
      :git_ref => "master",
    },
    "api_umbrella_web" => {
      :git => "https://github.com/NREL/api-umbrella-web.git",
      :git_ref => "master",
    },
    "beanstalkd" => {
      :git => "https://github.com/kr/beanstalkd.git",
    },
    "bundler" => {
      :git => "https://github.com/bundler/bundler.git",
      :constraint => "~> 1.7.13",
    },
    "dnsmasq" => {
      :git => "git://thekelleys.org.uk/dnsmasq.git",
    },
    "elasticsearch" => {
      :git => "https://github.com/elasticsearch/elasticsearch.git",
    },
    "elasticsearch_bigdesk" => {
      :git => "https://github.com/lukas-vlcek/bigdesk.git",
    },
    "elasticsearch_head" => {
      :git => "https://github.com/mobz/elasticsearch-head.git",
      :git_ref => "master",
    },
    "elasticsearch_hq" => {
      :git => "https://github.com/royrusso/elasticsearch-HQ.git",
      :git_ref => "master",
    },
    "mongodb" => {
      :git => "https://github.com/mongodb/mongo.git",
      :constraint => "~> 2.6.3",
    },
    "nginx" => {
      :git => "https://github.com/nginx/nginx.git",
    },
    "nginx_echo" => {
      :git => "https://github.com/openresty/echo-nginx-module.git",
    },
    "nginx_headers_more" => {
      :git => "https://github.com/openresty/headers-more-nginx-module.git",
    },
    "nginx_txid" => {
      :git => "https://github.com/streadway/ngx_txid.git",
      :git_ref => "master",
    },
    "nodejs" => {
      :git => "https://github.com/joyent/node.git",
      :constraint => "~> 0.10.29",
    },
    "openssl" => {
      :git => "https://github.com/openssl/openssl.git",
      :string_version => true,
    },
    "redis" => {
      :git => "https://github.com/antirez/redis.git",
      :constraint => "~> 2.8.19",
    },
    "ruby" => {
      :git => "https://github.com/ruby/ruby.git",
      :constraint => "~> 2.1.5",
    },
    "rubygems" => {
      :git => "https://github.com/rubygems/rubygems.git",
    },
    "supervisor" => {
      :git => "https://github.com/Supervisor/supervisor.git",
    },
    "supervisor_serialrestart" => {
      :git => "https://github.com/native2k/supervisor-serialrestart.git",
    },
    "varnish" => {
      :git => "https://github.com/varnish/Varnish-Cache.git",
    },
  }

  config = File.read("config/projects/api-umbrella.rb")

  versions = {}
  repos.each do |name, options|
    current_version_matches = config.match(/^override :#{name}, *version: *['"](v?.+?)['"]/)
    if(!current_version_matches)
      raise "version override for #{name} not found in config/projects/api-umbrella.rb"
    end

    current_version_string = current_version_matches[1]
    current_version = current_version_string.gsub(/^v/, "")
    versions[name] = {
      :current_version => current_version,
    }

    unless(options[:string_version] || options[:git_ref])
      versions[name][:current_version] = Semverse::Version.new(current_version)
    end

    constraint = Semverse::Constraint.new(options[:constraint])

    if(options[:git] && options[:git_ref])
      current_commit = current_version_string
      if(current_commit !~ /^[0-9a-f]{5,40}$/)
        current_commit = `git ls-remote #{options[:git]} #{current_version_string}`.split(/\s/).first
        if(current_commit.to_s.empty?)
          puts "#{name}: Could not parse version #{current_version_string}"
        end
      end

      latest_commit = `git ls-remote #{options[:git]} #{options[:git_ref]}`.split(/\s/).first
      if(latest_commit.to_s.empty?)
        puts "#{name}: Could not parse latest commit: git ls-remote #{options[:git]} #{options[:git_ref]}"
      end

      versions[name][:current_version] = current_commit[0,7]
      versions[name][:latest_version] = latest_commit[0,7]
      versions[name][:wanted_version] = latest_commit[0,7]
    elsif(options[:git])
      raw_tags = `git ls-remote --tags #{options[:git]}`
      tags = raw_tags.lines.map do |line|
        tag = line.match(%r{refs/tags/(.+)$})[1]

        tag.downcase!
        tag.gsub!(/\^{}$/, "")
        case(name)
        when "mongodb"
          tag.gsub!(/^r/, "")
        when "ruby"
          tag.gsub!(/_/, ".")
        when "varnish"
          tag.gsub!(/^varnish-/, "")
        when "openssl"
          tag.gsub!(/^OpenSSL_/i, "")
          tag.gsub!(/_/, ".")
        end

        tag.gsub!(/^v/, "")
        tag.gsub!(/(\d)[\._]?(beta|rc|pre|alpha|dev|test)/, '\1-\2')
        tag.gsub!(/(\d)([a-z][\d\.]+)$/, '\1-\2')
        tag.gsub!(/(\d+\.\d+\.\d+)\.(\d+)$/, '\1+\2')
        tag.gsub!(/^(\d+\.\d+)-([a-z])/, '\1.0-\2')
        tag
      end

      tags.select! { |tag| tag =~ /^\d+\.\d+/ }
      case(name)
      when "openssl"
        tags.select! { |tag| tag =~ /^\d+\.\d+\.\d+[a-z]?$/ }
      end

      tags.compact!
      tags.uniq!

      unparsable = []
      tags.each do |tag|
        if(options[:string_version])
          available_version = tag
          if(!versions[name][:latest_version] || available_version > versions[name][:latest_version])
            versions[name][:latest_version] = available_version
            versions[name][:wanted_version] = available_version
          end
        else
          begin
            available_version = Semverse::Version.new(tag)

            next if(available_version.pre_release?)

            if(!versions[name][:latest_version] || available_version > versions[name][:latest_version])
              versions[name][:latest_version] = available_version
            end

            if(constraint.satisfies?(available_version))
              if(!versions[name][:wanted_version] || available_version > versions[name][:wanted_version])
                versions[name][:wanted_version] = available_version
              end
            end
          rescue Semverse::InvalidVersionFormat => e
            unparsable << tag
          end
        end
      end

      if(unparsable.any?)
        puts "#{name}: Could not parse version tag #{unparsable.join(", ")}"
      end
    end
  end

  puts "\n\n"

  print Rainbow("Package".ljust(32)).underline
  print Rainbow("Current".rjust(16)).underline
  print Rainbow("Wanted".rjust(16)).underline
  print Rainbow("Latest".rjust(16)).underline
  puts ""

  versions.each do |name, info|
    name_column = name.ljust(32)
    if(info[:wanted_version] != info[:current_version])
      print Rainbow(name_column).red
    elsif(info[:current_version] != info[:latest_version])
      print Rainbow(name_column).yellow
    else
      print name_column
    end
    print info[:current_version].to_s.rjust(16)
    print Rainbow(info[:wanted_version].to_s.rjust(16)).green
    print Rainbow(info[:latest_version].to_s.rjust(16)).magenta
    puts ""
  end
end
