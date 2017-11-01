describe Moip2::ConnectClient do
  let(:auth) do
    Moip2::Auth::Basic.new("TOKEN", "SECRET")
  end

  let(:oauth) do
    Moip2::Auth::OAuth.new "9fdc242631454d4c95d82e27b4127394_v2"
  end

  describe "initialize env with string" do
    let(:client) do
      described_class.new "sandbox", auth
    end

    it { expect(client.env).to eq :sandbox }
  end

  describe "initialize on sandbox with OAuth" do
    let(:client) do
      described_class.new :sandbox, oauth
    end

    it { expect(client.uri).to eq "https://connect-sandbox.moip.com.br" }
    it { expect(client.env).to eq :sandbox }
    it do
      expect(client.opts[:headers]["Authorization"]).
        to eq "OAuth 9fdc242631454d4c95d82e27b4127394_v2"
    end
  end

  describe "initialize on production with OAuth" do
    let(:client) do
      described_class.new :production, oauth
    end

    it { expect(client.uri).to eq "https://connect.moip.com.br" }
    it { expect(client.env).to eq :production }
    it do
      expect(client.opts[:headers]["Authorization"]).
        to eq "OAuth 9fdc242631454d4c95d82e27b4127394_v2"
    end
  end

  describe "initialize on sandbox with Basic authentication" do
    let(:client) do
      described_class.new :sandbox, auth
    end

    it { expect(client.uri).to eq "https://connect-sandbox.moip.com.br" }
    it { expect(client.env).to eq :sandbox }
    it { expect(client.opts[:headers]["Authorization"]).to eq "Basic VE9LRU46U0VDUkVU" }
  end

  describe "initialize on production with Basic authentication" do
    let(:client) do
      described_class.new :production, auth
    end

    it { expect(client.uri).to eq "https://connect.moip.com.br" }
    it { expect(client.env).to eq :production }
    it { expect(client.opts[:headers]["Authorization"]).to eq "Basic VE9LRU46U0VDUkVU" }
  end
end
