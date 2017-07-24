describe Moip2::OAuthApi do
  let(:oauth_api) { described_class.new(sandbox_client) }

  describe "#authorization_url" do
    describe "with simple parameters" do
      let(:subject) do
        oauth_api.authorization_url(
          client_id: "APP-M11STAPPOAUt",
          redirect_uri: "https://labs.moip.com.br",
          scope: ["RECEIVE_FUNDS", "TRANSFER_FUNDS", "REFUND"],
        )
      end

      it {
        is_expected.to eq "https://connect-sandbox.moip.com.br/oauth/authorize?"\
                          "response_type=code&client_id=APP-M11STAPPOAUt"\
                          "&redirect_uri=https://labs.moip.com.br"\
                          "&scope=RECEIVE_FUNDS,TRANSFER_FUNDS,REFUND"
      }
    end

    describe "with query params in redirect_uri" do
      let(:subject) do
        oauth_api.authorization_url(
          client_id: "APP-M11STAPPOAUt",
          redirect_uri: "https://labs.moip.com.br/callback?seller_id=zaz&foo=bar",
          scope: ["RECEIVE_FUNDS", "TRANSFER_FUNDS", "REFUND"],
        )
      end

      it {
        is_expected.to eq "https://connect-sandbox.moip.com.br/oauth/authorize?"\
                          "response_type=code&client_id=APP-M11STAPPOAUt"\
                          "&redirect_uri=https%3A%2F%2Flabs.moip.com.br%2Fcallback%3Fseller_id%3Dzaz%26foo%3Dbar"\
                          "&scope=RECEIVE_FUNDS,TRANSFER_FUNDS,REFUND"
      }
    end

  end
end
