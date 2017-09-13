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
end
