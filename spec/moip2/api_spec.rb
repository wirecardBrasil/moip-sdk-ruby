describe Moip2::Api do

  let(:api) { described_class.new(:sandbox, token: "01010101010101010101010101010101", secret: "ABABABABABABABABABABABABABABABABABABABAB") }

  describe "#order" do

    it "returns an OrderApi" do
      expect(api.order).to be_a(Moip2::OrderApi)
    end

  end

end
