describe Moip2::EntryApi do
  let(:entry_api) { described_class.new(sandbox_oauth_client) }

  describe "#show" do
    let(:created_entry_show) do
      VCR.use_cassette("show_entries") do
          entry_api.show("ENT-2JHP5A593QSW")
      end
    end

    it "show especif entry" do
      expect(created_entry_show.description).to eq "Cartao de credito - Pedido ORD-UF4E00XMFDL1"
    end

    it "verify if amout present" do
      expect(created_entry_show.installment.amount).to eq 1
    end

    it "verify if amout type present" do
      expect(created_entry_show.type).to eq "CREDIT_CARD"
    end

    it "verify if status present" do
      expect(created_entry_show["status"]).to eq "SETTLED"
    end

    it "verify if events present" do
      expect(created_entry_show.event_id).to eq "PAY-AQITTDNDKBU9"
    end
  end

  describe "#find_all" do
    let(:created_entries_find_all) do
      VCR.use_cassette("find_all_entries") do
          entry_api.find_all
      end
    end

    it "find all entries" do
      expect(created_entries_find_all.parsed_response.first["external_id"]).to eq"ENT-2JHP5A593QSW"
    end
  end
end
