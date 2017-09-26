describe Moip2::Resource::Order do
  let(:order) do
    described_class.new(sandbox_client, Moip2::Response.new(nil, external_id: "ORD-UEK2XGEXNWL9"))
  end

  describe "#create_payment" do
    let(:created_payment) do
      VCR.use_cassette("create_payment_success") do
        order.create_payment(installmentCount: 1,
                             fundingInstrument: {
                               method: "CREDIT_CARD",
                               creditCard: {
                                 expirationMonth: 05,
                                 expirationYear: 18,
                                 number: "4012001038443335",
                                 cvc: "123",
                                 holder: {
                                   fullname: "Jose Portador da Silva",
                                   birthdate: "1988-12-30",
                                   taxDocument: {
                                     type: "CPF",
                                     number: "33333333333",
                                   },
                                   phone: {
                                     countryCode: "55",
                                     areaCode: "11",
                                     number: "66778899",
                                   },
                                 },
                               },
                             })
      end
    end

    it "creates a credit card payment on moip" do
      expect(created_payment.id).to eq("PAY-W3MNW718O3AI")
    end

    it "returns a Payment object" do
      expect(created_payment).to be_a(Moip2::Resource::Payment)
    end
  end
end
