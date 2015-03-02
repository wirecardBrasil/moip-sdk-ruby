describe Moip2::CustomerApi do

  let(:customer_api) { described_class.new(sandbox_client) }

  describe "#show" do

    let(:customer_external_id) { "CUS-B6LE6HLFFXKF" }

    let(:customer) do
      VCR.use_cassette("get_customer") do
        customer_api.show(customer_external_id)
      end
    end

    it "should recover customer information" do
      expect(customer.id).to eq customer_external_id
      expect(customer.own_id).to eq "your_customer_own_id"
      expect(customer.email).to eq "john.doe@mailinator.com"
      expect(customer.funding_instrument).to_not be_nil

      expect(customer.funding_instrument.credit_card.id).to eq "CRC-OQPJYLGZOY7P"
      expect(customer.funding_instrument.credit_card.brand).to eq "VISA"

      expect(customer.phone).to_not be_nil

      expect(customer.tax_document).to_not be_nil
      expect(customer.tax_document.type).to eq "CPF"

      expect(customer.shipping_address).to_not be_nil
      expect(customer.shipping_address.zip_code).to eq "01234000"

      expect(customer._links).to_not be_nil
      expect(customer._links.self.href).to eq "https://test.moip.com.br/v2/customers/CUS-B6LE6HLFFXKF"
    end

  end

end
