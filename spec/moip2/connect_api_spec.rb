describe Moip2::ConnectApi do
  let(:connect_api) { described_class.new sandbox_client_connect }

  describe "#authorize_url" do
    let (:authorize_url) do
      connect_api.authorize_url(
        "APP-XT5FIAK2F8I7",
        "http://localhost/moip/callback.php",
        "RECEIVE_FUNDS,REFUND,MANAGE_ACCOUNT_INFO,RETRIEVE_FINANCIAL_INFO,TRANSFER_FUNDS",
      )
    end

    it "get authorize url" do
      expect(authorize_url).to eq(
        "https://connect-sandbox.moip.com.br/oauth/authorize"\
        "?response_type=code&client_id=APP-XT5FIAK2F8I7"\
        "&redirect_uri=http%3A%2F%2Flocalhost%2Fmoip%2Fcallback.php"\
        "&scope=RECEIVE_FUNDS%2CREFUND%2CMANAGE_ACCOUNT_INFO%2CRETRIEVE_FINANCIAL_INFO%2CTRANSFER_FUNDS",
      )
    end
  end

  describe "#generate_oauth_token" do
    let (:oauth_token) do
      VCR.use_cassette("generate_oauth_token") do
        connect_api.authorize(
          client_id: "APP-Y0YCCJ5P603B",
          client_secret: "363cdf8ab70a4c5aa08017564c08efbe",
          code: "4efde1f89d9acc3b12124ccfded146518465e423",
          redirect_uri: "http://localhost/moip/callback.php",
          grant_type: "authorization_code",
        )
      end
    end

    it "token generated" do
      expect(oauth_token.refresh_token).to_not be_nil
      expect(oauth_token.scope).to eq (
        "DEFINE_PREFERENCES,MANAGE_ACCOUNT_INFO,RECEIVE_FUNDS,"\
        "REFUND,RETRIEVE_FINANCIAL_INFO,TRANSFER_FUNDS"
      )
      expect(oauth_token.access_token).to_not be_nil
      expect(oauth_token.expires_in).to eq "2027-09-15"
    end
  end
end
