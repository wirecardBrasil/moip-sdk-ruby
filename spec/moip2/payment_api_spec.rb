describe Moip2::PaymentApi do
  let(:payment_api) { described_class.new(sandbox_client) }

  context "with credit card data" do
    let(:created_payment) do
      VCR.use_cassette("create_payment_success") do
        payment_api.create(
          "ORD-UEK2XGEXNWL9",
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
                  number: "33333333333",
                },
                phone: {
                  countryCode: "55",
                  areaCode: "11",
                  number: "66778899",
                },
              },
            },
          },
        )
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
        payment_api.create(
          "ORD-DDT31SU6LXZO",
          installmentCount: 1,
          fundingInstrument: {
            method: "CREDIT_CARD",
            creditCard: {
              hash: "Pf/FTHX09EwW+9mAd2+jhqhVWE8LtdYp+rfoqrSXelFqgkRRdpvcQTKKGA3TVbuInIrH03Cq0Fq1X"\
                    "VwBDgF9EDtFO+L3kacfAl4hfKr55wkvi7yAAZ9MnhqXCzxm+0aOdoc/0UqnsHlxCzpwaGqBZZkQ6M"\
                    "t+V1e26fxne4OJw2XJeLMOHpPnMM23Uk8BhSsCUVffmiIuE+Ep9VD9b3HkJPqGRPFiKnYT29J6PH2"\
                    "mKYT61u8KM6ZKQu7FmKTtYs25tHtQ2mN7WhfLbAqLARnfBrCKg1a3W+kcWSf4Wjc0z7LWHzFCvT9v"\
                    "xnq8W/fDBAbue102mouV37dlKR8yN7UgZA==",
              holder: {
                fullname: "Jose Portador da Silva",
                birthdate: "1988-12-30",
                taxDocument: {
                  type: "CPF",
                  number: "33333333333",
                },
              },
            },
          },
        )
      end
    end

    it "creates a credit card payment on moip" do
      expect(created_payment.id).to eq("PAY-CRUP19YU2VE1")
    end

    it "returns a Payment object" do
      expect(created_payment).to be_a(Moip2::Resource::Payment)
    end
  end

  describe "#show" do
    let (:payment_id) { "PAY-CRUP19YU2VE1" }

    let(:payment) do
      VCR.use_cassette("get_payment") do
        payment_api.show(payment_id)
      end
    end

    it { expect(payment.id).to eq payment_id }
    it { expect(payment.status).to eq "AUTHORIZED" }
    it { expect(payment.installment_count).to eq 1 }
    it { expect(payment.funding_instrument).to_not be_nil }
    it { expect(payment.funding_instrument.credit_card).to_not be_nil }
    it { expect(payment.funding_instrument.credit_card.brand).to eq "MASTERCARD" }

    context "when payment is not found" do
      let(:payment) do
        VCR.use_cassette("get_payment_not_found") do
          payment_api.show("MOR-INVALID")
        end
      end

      it "raises a NotFound" do
        expect { payment }.to raise_error Moip2::NotFoundError
      end
    end
  end

  describe "#capture" do
    let (:captured_payment) do
      VCR.use_cassette("capture_payment") do
        payment_api.capture("PAY-KT5OSI01X8QU")
      end
    end

    it { expect(captured_payment.id).to eq "PAY-KT5OSI01X8QU" }
    it { expect(captured_payment.status).to eq "AUTHORIZED" }
    it { expect(captured_payment.funding_instrument).to_not be_nil }
    it { expect(captured_payment.installment_count).to eq 1 }
  end

  describe "#void" do
    let (:cancelled_payment) do
      VCR.use_cassette("cancel_payment") do
        payment_api.void("PAY-IXNGCU456GG4")
      end
    end

    it { expect(cancelled_payment.id).to eq "PAY-IXNGCU456GG4" }
    it { expect(cancelled_payment.status).to eq "CANCELLED" }
    it { expect(cancelled_payment.funding_instrument).to_not be_nil }
    it { expect(cancelled_payment.installment_count).to eq 1 }
  end
end
