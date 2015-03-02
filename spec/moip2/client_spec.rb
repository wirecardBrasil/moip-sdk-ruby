describe Moip2::Client do

  let(:auth) do
    Moip2::Auth::Basic.new("TOKEN", "SECRET")
  end

  describe "initialize on sandbox with base_uri" do

    before do
      ENV['base_uri'] = "http://localhost:5000"
    end

    let(:client) do
      described_class.new :sandbox, auth
    end

    it { expect(client.uri).to eq "http://localhost:5000" }
    it { expect(client.env).to eq :sandbox }

  end

  describe "initialize on production with base_uri" do

    before do
      ENV['base_uri'] = "http://localhost:5000"
    end

    let(:client) do
      described_class.new :production, auth
    end

    it { expect(client.uri).to eq "http://localhost:5000" }
    it { expect(client.env).to eq :production }

  end

  describe "initialize on sandbox" do

    before do
      ENV['base_uri'] = nil
    end

    let(:client) do
      described_class.new :sandbox, auth
    end

    it { expect(client.uri).to eq "https://test.moip.com.br" }
    it { expect(client.env).to eq :sandbox }
  end

  describe "initialize on production" do
    let(:client) do
      described_class.new :production, auth
    end

    it { expect(client.uri).to eq "https://api.moip.com.br" }
    it { expect(client.env).to eq :production }
  end

end
