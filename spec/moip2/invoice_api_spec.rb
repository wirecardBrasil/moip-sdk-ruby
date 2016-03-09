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

    let(:client) { double "Moip2::Client" }
    let(:pagination) do
      {
        limit: "10",
        offset: "50"
      }
    end

    subject do
      Moip2::InvoiceApi.new(client)
    end

    describe "query" do
      let(:filters) do
        { q: "teste" }
      end

      before do
        expect(client).to receive(:get).with("/v2/invoices", { filters: { q: "teste", begin_date: nil, end_date: nil, status: nil, vmin: nil, vmax: nil }, pagination: { limit: nil, offset: nil } })
      end

      it{ expect(subject.list(filters)) }
    end

    describe "status" do
      describe "one" do
        let(:filters) do
          { status: "DELIVERED" }
        end

        before do
          expect(client).to receive(:get).with("/v2/invoices", {:filters=>{:q=>nil, :begin_date=>nil, :end_date=>nil, :status=>"DELIVERED", :vmin=>nil, :vmax=>nil}, :pagination=>{:limit=>nil, :offset=>nil}})
        end

        it{ expect(subject.list(filters)) }
      end

      describe "two" do
        let(:filters) do
          { status: ["DELIVERED","NOT_PAID"] }
        end

        before do
          expect(client).to receive(:get).with("/v2/invoices", {:filters=>{:q=>nil, :begin_date=>nil, :end_date=>nil, :status=>["DELIVERED", "NOT_PAID"], :vmin=>nil, :vmax=>nil}, :pagination=>{:limit=>nil, :offset=>nil}})
        end

        it{ expect(subject.list(filters)) }
      end
    end

    describe "date" do
      let(:filters) do
        {
          begin_date: "2016-02-28",
          end_date: "2016-02-28"
        }
      end

      before do
        expect(client).to receive(:get).with("/v2/invoices", {:filters=>{:q=>nil, :begin_date=>"2016-02-28", :end_date=>"2016-02-28", :status=>nil, :vmin=>nil, :vmax=>nil}, :pagination=>{:limit=>nil, :offset=>nil}})
      end

      it{ expect(subject.list(filters)) }
    end

    describe "value" do
      describe "between" do
        let(:filters) do
          {
            vmin: "1234",
            vmax: "2345"
          }
        end

        before do
          expect(client).to receive(:get).with("/v2/invoices", {:filters=>{:q=>nil, :begin_date=>nil, :end_date=>nil, :status=>nil, :vmin=>"1234", :vmax=>"2345"}, :pagination=>{:limit=>nil, :offset=>nil}})
        end

        it{ expect(subject.list(filters)) }
      end

      describe "lower than" do
        let(:filters) do
          { vmax: "2345" }
        end

        before do
          expect(client).to receive(:get).with("/v2/invoices", {:filters=>{:q=>nil, :begin_date=>nil, :end_date=>nil, :status=>nil, :vmin=>nil, :vmax=>"2345"}, :pagination=>{:limit=>nil, :offset=>nil}})
        end

        it{ expect(subject.list(filters)) }
      end

      describe "higher than" do
        let(:filters) do
          { vmin: "1234" }
        end

        before do
          expect(client).to receive(:get).with("/v2/invoices", {:filters=>{:q=>nil, :begin_date=>nil, :end_date=>nil, :status=>nil, :vmin=>"1234", :vmax=>nil}, :pagination=>{:limit=>nil, :offset=>nil}})
        end

        it{ expect(subject.list(filters)) }
      end

    end

    describe "all" do
      let(:filters) do
        {
          q: "teste",
          status: ["DELIVERED","NOT_PAID"],
          begin_date: "2016-02-28",
          end_date: "2016-02-28",
          vmin: "1234",
          vmax: "2345",
          limit: "10",
          offset: "50"
        }
      end

      before do
        expect(client).to receive(:get).with("/v2/invoices", {:filters=>{:q=>"teste", :begin_date=>"2016-02-28", :end_date=>"2016-02-28", :status=>["DELIVERED", "NOT_PAID"], :vmin=>"1234", :vmax=>"2345"}, :pagination=>{:limit=>"10", :offset=>"50"}})
      end

      it{ expect(subject.list(filters)) }
    end
  end

end
