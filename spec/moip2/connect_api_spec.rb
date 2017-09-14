describe Moip2::ConnectApi do
  let(:connect_api) { described_class.new sandbox_oauth_client }

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
          client_id: "APP-EQMTJ8WEHO71",
          client_secret: "78bdf2e876b240f6a4e0c10fdf6d8cc1",
          code: "8ee7a54a62c184d1ba0b64ebcabd6623d61b030c",
          redirect_uri: "http://localhost/test-moip-sdk-php/callback.php",
          grant_type: "authorization_code",
        )
      end
    end

    it "token generated" do
      expect(oauth_token).to eq("")
    end
  end
end
