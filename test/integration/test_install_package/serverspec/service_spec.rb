require "serverspec"
require "rest_client"

set :backend, :exec

describe "api-umbrella" do
  it "runs the service" do
    expect(service("api-umbrella")).to be_running
  end

  it "enables the service" do
    expect(service("api-umbrella")).to be_enabled
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
end
