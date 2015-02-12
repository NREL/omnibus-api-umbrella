require "bundler"
require "serverspec"
require "rest_client"
require "yaml"

set :backend, :exec

describe "api-umbrella" do
  it "runs the service" do
    expect(service("api-umbrella")).to be_running
  end

  it "enables the service" do
    expect(service("api-umbrella")).to be_enabled
  end

  it "reported bin version matches package build version" do
    env = YAML.load(File.read("/tmp/api_umbrella_omnibus_test_env.yml"))
    expect(`api-umbrella --version`.strip).to eql("version #{env["api_umbrella_version"]}")
  end

  it "reports the correct status regardless of HOME environment variable" do
    # This accounts for HOME being different under Ubuntu's boot than when
    # running "sudo /etc/init.d/api-umbrella *"
    # See: https://github.com/NREL/api-umbrella/issues/89
    expect(`env HOME=/ /etc/init.d/api-umbrella status`).to include("is running")
    expect(`env HOME=/foo /etc/init.d/api-umbrella status`).to include("is running")
    expect(`env HOME=/root /etc/init.d/api-umbrella status`).to include("is running")
  end

  it "listens on port 80" do
    expect(port(80)).to be_listening.on("0.0.0.0").with("tcp")
  end

  it "listens on port 443" do
    expect(port(443)).to be_listening.on("0.0.0.0").with("tcp")
  end

  it "signup page loads" do
    response = RestClient::Request.execute(:method => :get, :url => "https://localhost/signup/", :verify_ssl => false)
    expect(response).to include("API Key Signup")
  end

  it "admin login page loads" do
    response = RestClient::Request.execute(:method => :get, :url => "https://localhost/admin/login", :verify_ssl => false)
    expect(response).to include("Login with Persona")
  end

  it "gatekeeper blocks key-less requests" do
    expect do
      RestClient::Request.execute(:method => :get, :url => "https://localhost/api-umbrella/v1/test.json", :verify_ssl => false)
    end.to raise_error do |error|
      expect(error).to be_a(RestClient::Forbidden)
      expect(error.response).to include("API_KEY_MISSING")
    end
  end

  it "gatekeeper blocks invalid key requests" do
    expect do
      response = RestClient::Request.execute(:method => :get, :url => "https://localhost/api-umbrella/v1/test.json?api_key=INVALID_KEY", :verify_ssl => false)
    end.to raise_error do |error|
      expect(error).to be_a(RestClient::Forbidden)
      expect(error.response).to include("API_KEY_INVALID")
    end
  end

  it "fails immediately when startup script is called as an unauthorized user" do
    expect(`sudo -u api-umbrella-deploy /etc/init.d/api-umbrella start 2>&1`).to include("Could not open")
    expect($?.to_i).not_to eql(0)
  end

  it "allows the deploy user to execute api-umbrella as root" do
    expect(`sudo -u api-umbrella-deploy sudo -n api-umbrella status 2>&1`).to include("is running")
    expect(`sudo -u api-umbrella-deploy sudo -n /etc/init.d/api-umbrella status 2>&1`).to include("is running")
  end

  it "can be stopped and started again" do
    expect(`sudo /etc/init.d/api-umbrella stop 2>&1`).to include("OK")
    expect($?.to_i).to eql(0)

    expect(service("api-umbrella")).to_not be_running
    expect(process("supervisord")).to_not be_running
    expect(`sudo /etc/init.d/api-umbrella status 2>&1`).to include("is stopped")

    expect(`sudo /etc/init.d/api-umbrella start 2>&1`).to include("OK")
    expect($?.to_i).to eql(0)
    expect(service("api-umbrella")).to be_running
    expect(process("supervisord")).to be_running
  end

  it "symlinks the main api-umbrella binary" do
    subject = file("/usr/bin/api-umbrella")
    expect(subject).to be_symlink
    expect(subject).to be_owned_by("root")
    expect(subject).to be_grouped_into("root")
    expect(subject).to be_linked_to("/opt/api-umbrella/bin/api-umbrella")
  end

  it "installs a init.d file" do
    subject = file("/etc/init.d/api-umbrella")
    expect(subject).to be_file
    expect(subject).to be_mode(755)
    expect(subject).to be_owned_by("root")
    expect(subject).to be_grouped_into("root")
  end

  it "installs a logrotate.d file" do
    subject = file("/etc/logrotate.d/api-umbrella")
    expect(subject).to be_file
    expect(subject).to be_mode(644)
    expect(subject).to be_owned_by("root")
    expect(subject).to be_grouped_into("root")
  end

  it "installs a sudoers.d file" do
    subject = file("/etc/sudoers.d/api-umbrella")
    expect(subject).to be_file
    expect(subject).to be_mode(440)
    expect(subject).to be_owned_by("root")
    expect(subject).to be_grouped_into("root")
  end

  it "installs a api-umbrella.yml file" do
    subject = file("/etc/api-umbrella/api-umbrella.yml")
    expect(subject).to be_file
    expect(subject).to be_mode(644)
    expect(subject).to be_owned_by("root")
    expect(subject).to be_grouped_into("root")
  end

  it "sets up the api-umbrella user" do
    subject = user("api-umbrella")
    expect(subject).to exist
    expect(subject).to belong_to_group("api-umbrella")
    expect(subject).to have_home_directory("/opt/api-umbrella")
    expect(subject).to have_login_shell("/sbin/nologin")
  end

  it "sets up the api-umbrella-deploy user's home directory and empty ssh keys file" do
    subject = user("api-umbrella-deploy")
    expect(subject).to exist
    expect(subject).to belong_to_group("api-umbrella-deploy")
    expect(subject).to have_home_directory("/home/api-umbrella-deploy")
    expect(subject).to have_login_shell("/bin/bash")

    subject = file("/home/api-umbrella-deploy")
    expect(subject).to be_directory
    expect(subject).to be_mode(700)
    expect(subject).to be_owned_by("api-umbrella-deploy")
    expect(subject).to be_grouped_into("api-umbrella-deploy")

    subject = file("/home/api-umbrella-deploy/.ssh")
    expect(subject).to be_directory
    expect(subject).to be_mode(700)
    expect(subject).to be_owned_by("api-umbrella-deploy")
    expect(subject).to be_grouped_into("api-umbrella-deploy")

    subject = file("/home/api-umbrella-deploy/.ssh/authorized_keys")
    expect(subject).to be_file
    expect(subject).to be_mode(600)
    expect(subject).to be_owned_by("api-umbrella-deploy")
    expect(subject).to be_grouped_into("api-umbrella-deploy")
    expect(subject.content).to eql("")
  end

  it "symlinks the log directory" do
    subject = file("/var/log/api-umbrella")
    expect(subject).to be_symlink
    expect(subject).to be_owned_by("root")
    expect(subject).to be_grouped_into("root")
    expect(subject).to be_linked_to("/opt/api-umbrella/var/log")
  end
end
