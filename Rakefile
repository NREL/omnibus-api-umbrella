# A task for trying to find outdated software versions based on what's being
# built versus what's available.
task :outdated do
  require "semverse"
  require "rainbow"

  repos = {
    "beanstalkd" => {
      :git => "https://github.com/kr/beanstalkd.git",
    },
    "bundler" => {
      :git => "https://github.com/bundler/bundler.git",
    },
    "elasticsearch" => {
      :git => "https://github.com/elasticsearch/elasticsearch.git",
    },
    "luajit" => {
      :git => "http://luajit.org/git/luajit-2.0.git",
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
    "nginx_devel_kit" => {
      :git => "https://github.com/simpl/ngx_devel_kit.git",
    },
    "nginx_lua" => {
      :git => "https://github.com/openresty/lua-nginx-module.git",
    },
    "nodejs" => {
      :git => "https://github.com/joyent/node.git",
      :constraint => "~> 0.10.29",
    },
    "redis" => {
      :git => "https://github.com/antirez/redis.git",
    },
    "ruby" => {
      :git => "https://github.com/ruby/ruby.git",
    },
    "rubygems" => {
      :git => "https://github.com/rubygems/rubygems.git",
    },
    "serf" => {
      :git => "https://github.com/hashicorp/serf.git",
    },
    "supervisor" => {
      :git => "https://github.com/Supervisor/supervisor.git",
    },
    "trafficserver" => {
      :git => "https://github.com/apache/trafficserver.git",
    },
    "varnish" => {
      :git => "https://github.com/varnish/Varnish-Cache.git",
    },
  }

  config = File.read("config/projects/api-umbrella.rb")

  versions = {}
  repos.each do |name, options|
    versions[name] = {
      :current_version => Semverse::Version.new(config.match(/^override :#{name}.*'v?(.+)'$/)[1]),
    }

    constraint = Semverse::Constraint.new(options[:constraint])

    if(options[:git])
      raw_tags = `git ls-remote --tags #{options[:git]}`
      tags = raw_tags.lines.map do |line|
        tag = line.match(%r{refs/tags/(.+)$})[1]

        tag.downcase!
        tag.gsub!(/\^{}$/, "")
        #tag.gsub!(/^[^0-9]+/, "")
        case(name)
        when "mongodb"
          tag.gsub!(/^r/, "")
        when "passenger"
          tag.gsub!(/^release-/, "")
        when "ruby"
          tag.gsub!(/_/, ".")
        when "varnish"
          tag.gsub!(/^varnish-/, "")
        end

        tag.gsub!(/^v/, "")
        tag.gsub!(/(\d)[\._]?(beta|rc|pre|alpha|dev)/, '\1-\2')
        tag.gsub!(/(\d)([a-z][\d\.]+)$/, '\1-\2')
        tag.gsub!(/(\d+\.\d+\.\d+)\.(\d+)$/, '\1+\2')
        tag.gsub!(/^(\d+\.\d+)-([a-z])/, '\1.0-\2')
        tag
      end

      tags.select! { |tag| tag =~ /^\d+\.\d+/ }

      tags.compact!
      tags.uniq!

      unparsable = []
      tags.each do |tag|
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

      if(unparsable.any?)
        puts "#{name}: Could not parse version tag #{unparsable.join(", ")}"
      end
    end
  end

  puts "\n\n"

  print Rainbow("Package".ljust(20)).underline
  print Rainbow("Current".rjust(16)).underline
  print Rainbow("Wanted".rjust(16)).underline
  print Rainbow("Latest".rjust(16)).underline
  puts ""

  versions.each do |name, info|
    name_column = name.ljust(20)
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
