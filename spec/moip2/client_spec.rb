describe Moip2::Client do
  let(:auth) do
    Moip2::Auth::Basic.new("TOKEN", "SECRET")
  end

  let(:oauth) do
    Moip2::Auth::OAuth.new "d63tz2xwyu0ewrembove4j5cbv2otpd"
  end

  describe "initialize env with string" do
    let(:client) do
      described_class.new "sandbox", auth
    end

    it { expect(client.env).to eq :sandbox }
  end

  describe "initialize on sandbox with OAuth" do
    let(:client) do
      described_class.new :sandbox, auth
    end

    let(:client) { described_class.new :sandbox, oauth }
    it { expect(client.uri).to eq ENV["sandbox_url"] }
    it { expect(client.env).to eq :sandbox }
    it { expect(client.opts[:headers]["Authorization"]).to eq "OAuth d63tz2xwyu0ewrembove4j5cbv2otpd" }
  end

  describe "initialize on production" do
    let(:client) do
      described_class.new :production, oauth
    end

    it { expect(client.uri).to eq "https://api.moip.com.br" }
    it { expect(client.env).to eq :production }
    it { expect(client.opts[:headers]["Authorization"]).to eq "OAuth d63tz2xwyu0ewrembove4j5cbv2otpd" }
  end

  describe "initialize on sandbox with base_uri and OAuth" do
    before do
      ENV["base_uri"] = "http://localhost:5000"
    end

    let(:client) do
      described_class.new :sandbox, oauth
    end

    it { expect(client.uri).to eq "http://localhost:5000" }
    it { expect(client.env).to eq :sandbox }
    it { expect(client.opts[:headers]["Authorization"]).to eq "OAuth d63tz2xwyu0ewrembove4j5cbv2otpd" }
  end

  describe "initialize on production with base_uri and OAuth" do
    before do
      ENV["base_uri"] = "http://localhost:5000"
    end

    let(:client) do
      described_class.new :production, oauth
    end

    it { expect(client.uri).to eq "http://localhost:5000" }
    it { expect(client.env).to eq :production }
    it { expect(client.opts[:headers]["Authorization"]).to eq "OAuth d63tz2xwyu0ewrembove4j5cbv2otpd" }
  end

  describe "initialize on sandbox with base_uri" do
    before do
      ENV["base_uri"] = "http://localhost:5000"
    end

    let(:client) do
      described_class.new :sandbox, auth
    end

    it { expect(client.uri).to eq "http://localhost:5000" }
    it { expect(client.env).to eq :sandbox }
    it { expect(client.opts[:headers]["Authorization"]).to eq "Basic VE9LRU46U0VDUkVU" }
  end

  describe "initialize on production with base_uri" do
    before do
      ENV["base_uri"] = "http://localhost:5000"
    end

    let(:client) do
      described_class.new :production, auth
    end

    it { expect(client.uri).to eq "http://localhost:5000" }
    it { expect(client.env).to eq :production }
    it { expect(client.opts[:headers]["Authorization"]).to eq "Basic VE9LRU46U0VDUkVU" }
  end

  describe "initialize on sandbox" do
    before do
      ENV["base_uri"] = nil
    end

    let(:client) do
      described_class.new :sandbox, auth
    end

    it { expect(client.uri).to eq ENV["sandbox_url"] }
    it { expect(client.env).to eq :sandbox }
    it { expect(client.opts[:headers]["Authorization"]).to eq "Basic VE9LRU46U0VDUkVU" }
  end

  describe "initialize on production" do
    let(:client) do
      described_class.new :production, auth
    end

    it { expect(client.uri).to eq "https://api.moip.com.br" }
    it { expect(client.env).to eq :production }
    it { expect(client.opts[:headers]["Authorization"]).to eq "Basic VE9LRU46U0VDUkVU" }
  end
end
