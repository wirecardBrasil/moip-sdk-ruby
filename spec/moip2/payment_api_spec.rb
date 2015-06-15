describe Moip2::PaymentApi do

  let(:payment_api) { described_class.new(sandbox_client)  }

  context "with credit card data" do
    let(:created_payment) do
      VCR.use_cassette("create_payment_success") do
        payment_api.create("ORD-UEK2XGEXNWL9", {
          installmentCount: 1,
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
                  number: "33333333333"
                },
                phone: {
                  countryCode: "55",
                  areaCode: "11",
                  number: "66778899"
                }
              }
            }
          }
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

  context "with credit card hash" do
    let(:created_payment) do
      VCR.use_cassette("create_payment_with_hash_success") do
        payment_api.create("ORD-DDT31SU6LXZO", {
          installmentCount: 1,
          fundingInstrument: {
            method: "CREDIT_CARD",
            creditCard: {
              hash: "Pf/FTHX09EwW+9mAd2+jhqhVWE8LtdYp+rfoqrSXelFqgkRRdpvcQTKKGA3TVbuInIrH03Cq0Fq1XVwBDgF9EDtFO+L3kacfAl4hfKr55wkvi7yAAZ9MnhqXCzxm+0aOdoc/0UqnsHlxCzpwaGqBZZkQ6Mt+V1e26fxne4OJw2XJeLMOHpPnMM23Uk8BhSsCUVffmiIuE+Ep9VD9b3HkJPqGRPFiKnYT29J6PH2mKYT61u8KM6ZKQu7FmKTtYs25tHtQ2mN7WhfLbAqLARnfBrCKg1a3W+kcWSf4Wjc0z7LWHzFCvT9vxnq8W/fDBAbue102mouV37dlKR8yN7UgZA==",
              holder: {
                fullname: "Jose Portador da Silva",
                birthdate: "1988-12-30",
                taxDocument: {
                  type: "CPF",
                  number: "33333333333"
                },
              }
            }
          }
        })
      end
    end

    it "creates a credit card payment on moip" do
      expect(created_payment.id).to eq("PAY-CRUP19YU2VE1")
    end

    it "returns a Payment object" do
      expect(created_payment).to be_a(Moip2::Resource::Payment)
    end
  end
end
