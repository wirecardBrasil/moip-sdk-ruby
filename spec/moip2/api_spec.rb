describe Moip2::Api do

  let(:auth) { Moip2::Auth::Basic.new('', '') }
  let(:client) { Moip2::Client.new(:sandbox, auth) }
  let(:api) { described_class.new client }

  describe "#order" do

    it "returns an OrderApi" do
      expect(api.order).to be_a(Moip2::OrderApi)
    end

  end

end
