describe Moip2 do

  describe ".new" do

    let(:auth) do
      Moip2::Auth::Basic.new("TOKEN", "SECRET")
    end

    let(:moip) do
      described_class.auth = auth
      described_class.new
    end

    it "creates a new Api using default environment" do
      expect(moip.client.env).to eq(:sandbox)
    end

    it "creates a new Api using defined auth" do
      expect(moip.client.auth).to eq(auth)
    end

    it "creates a new Client" do
      expect(moip).to be_a(Moip2::Api)
    end

  end

end
