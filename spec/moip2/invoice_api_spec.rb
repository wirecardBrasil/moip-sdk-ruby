describe Moip2::InvoiceApi do

  let(:invoice_api) { described_class.new sandbox_oauth_client }

  let(:invoice_external_id_to_update) do
    "INV-4517A209DDA9"
  end

  let(:invoice_external_id) do
    "INV-4C26A14CF75B"
  end

  describe "#create" do

    let(:invoice) do
      {
        invoiceAmount: 12610,
        description: "teste",
        customer: {
            email: "vagner.vieira@moip.com.br"
        },
        checkoutPreferences: {
            fundingInstruments: {
                suppressBoleto: true
            },
            installments: [
                {
                    quantity: [
                        1,
                        2
                    ]
                }
            ],
            suppressShippingAddress: true
          }
      }
    end

    let(:created_invoice) do
      VCR.use_cassette("create_invoice") do
        invoice_api.create invoice
      end
    end

    it { expect(created_invoice.id).to_not be_nil }
    it { expect(created_invoice.invoice_amount).to eq 12610 }
    it { expect(created_invoice.customer.email).to eq "vagner.vieira@moip.com.br" }
    it { expect(created_invoice.description).to eq "teste" }
    it { expect(created_invoice.checkout_preferences.funding_instruments.suppress_boleto).to be_truthy }
    it { expect(created_invoice.checkout_preferences.suppress_shipping_address).to be_truthy }

  end

  describe "#show" do

    let(:invoice) do
      VCR.use_cassette("get_invoice") do
        invoice_api.show invoice_external_id
      end
    end

    it { expect(invoice.id).to_not be_nil }
    it { expect(invoice.invoice_amount).to eq 12610 }
    it { expect(invoice.customer.email).to eq "vagner.vieira@moip.com.br" }
    it { expect(invoice.description).to eq "teste" }
    it { expect(invoice.checkout_preferences.funding_instruments.suppress_boleto).to be_truthy }
    it { expect(invoice.checkout_preferences.suppress_shipping_address).to be_truthy }

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
        invoice_api.update invoice_external_id_to_update, update_params
      end
    end

    it { expect(updated_invoice.id).to eq "INV-4517A209DDA9"  }

    it { expect(updated_invoice.order_external_id).to eq "ORD-NLQ916TW81TN"  }
    it { expect(updated_invoice.customer_external_id).to eq "CUS-GF45QI98NST1"  }

    it { expect(updated_invoice.email).to eq "caio.gama@moip.com.br" }
    it { expect(updated_invoice.type).to eq "subscription" }
    it { expect(updated_invoice.description).to eq "Assinatura da aula de desenho" }

  end

  describe "#list" do
    let (:result) do
      VCR.use_cassette("list_invoices") do
        invoice_api.list begin_date, end_date
      end
    end

    context "request with results" do



      it { expect(result).to_not be_nil }
      it { expect(result.invoices.size).to eq 2 }
      it { expect(result.invoices[0].id).to eq 'INV-635DC2BB9422' }
      it { expect(result.invoices[0].account_id).to eq 'MPA-MAROTO000000' }
      it { expect(result.invoices[1].id).to eq 'INV-635DC2BSHJ90' }
      it { expect(result.invoices[1].account_id).to eq 'MPA-MAROTO000000' }
    end

  end

end
