describe Moip2::InvoiceApi do

  let(:invoice_api) { described_class.new sandbox_oauth_client }

  let(:invoice_external_id) do
    "INV-4517A209DDA9"
  end

  describe "#create" do

    let(:invoice) do
      {
          amount: 13470,
          email: "caio.gama@moip.com.br",
          invoiceType: :subscription,
          description: "Assinatura da aula de desenho"
      }
    end

    let(:created_invoice) do
      VCR.use_cassette("create_invoice") do
        invoice_api.create invoice
      end
    end

    it { expect(created_invoice.id).to_not be_nil }
    it { expect(created_invoice.email).to eq "caio.gama@moip.com.br" }
    it { expect(created_invoice.type).to eq "subscription" }
    it { expect(created_invoice.description).to eq "Assinatura da aula de desenho" }

  end

  describe "#show" do

    let(:invoice) do
      VCR.use_cassette("get_invoice") do
        invoice_api.show invoice_external_id
      end
    end

    it { expect(invoice.id).to eq "INV-4517A209DDA9" }
    it { expect(invoice.email).to eq "caio.gama@moip.com.br" }
    it { expect(invoice.type).to eq "subscription" }
    it { expect(invoice.description).to eq "Assinatura da aula de desenho" }

  end

  describe "#update" do
    let(:update_params) do
      {
        orderExternalId: "ORD-NLQ916TW81TN",
        customerExternalId: "CUS-GF45QI98NST1"
      }
    end

    let(:updated_invoice) do
      VCR.use_cassette("update_invoice") do
        invoice_api.update invoice_external_id, update_params
      end
    end

    it { expect(updated_invoice.id).to eq "INV-4517A209DDA9"  }

    it { expect(updated_invoice.order_external_id).to eq "ORD-NLQ916TW81TN"  }
    it { expect(updated_invoice.customer_external_id).to eq "CUS-GF45QI98NST1"  }

    it { expect(updated_invoice.email).to eq "caio.gama@moip.com.br" }
    it { expect(updated_invoice.type).to eq "subscription" }
    it { expect(updated_invoice.description).to eq "Assinatura da aula de desenho" }

  end

end
