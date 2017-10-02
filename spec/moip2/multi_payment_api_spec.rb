describe Moip2::MultiPaymentApi do
  let(:multi_payment_api) { described_class.new(sandbox_client) }

  describe "#create" do
    let(:multi_payment) do
      {
        installmentCount: 1,
        fundingInstrument: {
          method: "CREDIT_CARD",
          creditCard: {
            expirationMonth: "05",
            expirationYear: "18",
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
      }
    end

    let(:created_multi_payment) do
      VCR.use_cassette("create_multi_payment_success") do
        multi_payment_api.create("MOR-IVKZDU55LXJU", multi_payment)
      end
    end

    it "creates a multiPayment at moip" do
      expect(created_multi_payment.id).to eq "MPY-DSA3I67FOKES"
      expect(created_multi_payment.payments).to_not be_nil
      expect(created_multi_payment.status).to eq "WAITING"
    end
  end

  describe "#show" do
    let(:multi_payment) do
      VCR.use_cassette("show_multi_payment") do
        multi_payment_api.show("MPY-DSA3I67FOKES")
      end
    end

    it "shows a multiPayment" do
      expect(multi_payment.id).to eq "MPY-DSA3I67FOKES"
      expect(multi_payment.payments).to_not be_nil
      expect(multi_payment.status).to eq "AUTHORIZED"
    end
  end

  describe "#capture" do
    let(:capture) do
      VCR.use_cassette("capture_multi_payment_sucess") do
        multi_payment_api.capture("MPY-89Q4R26EKU9D")
      end
    end

    it "updates the multipayment's statuses" do
      expect(capture.status).to eq("AUTHORIZED")
      expect(capture.payments).to satisfy do |payments|
        payments.all? { |payment| payment.status == "AUTHORIZED" }
      end
    end
  end
end
