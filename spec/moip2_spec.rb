describe Moip2 do

  describe ".new" do

    let(:auth) do
      Moip2::Auth::Basic.new("TOKEN", "SECRET")
    end

    
    let(:moip) do
      described_class.auth = auth
      described_class.new
    end

    let(:env) { "production" }
    
    let(:valid_env) { %i(sandbox production) }
    
    it "creates a new Api using default environment" do
      expect(moip.client.env).to eq(:sandbox)
    end

    it "creates a new Api using defined auth" do
      expect(moip.client.auth).to eq(auth)
    end

    it "creates a new Client" do
      expect(moip).to be_a(Moip2::Api)
    end
    
    it "valid_env comparision rails variable" do
      expect(valid_env).to include(env.to_sym)
    end
    
    context "when auth is not set" do

      let(:moip) do
        described_class.auth = nil
        described_class.new
      end

      it "raises an error" do
        expect { moip }.to raise_error
      end
    end

  end

end
