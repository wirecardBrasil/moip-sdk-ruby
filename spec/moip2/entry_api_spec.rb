describe Moip2::EntryApi do
  let(:entry_api) { described_class.new(sandbox_oauth_client) }


  describe "show entries" do
    let(:created_entries) do
      VCR.use_cassette("create_entries") do
        entry_api
      end
    end

      it "returns all entries" do
      entry = created_entries.index.entries[0]

      expect(entry["description"]).to eq "Cartao de credito - Pedido ORD-UF4E00XMFDL1"
      end

      it "returns an entry" do
        expect(created_entries.show("ENT-2JHP5A593QSW").external_id).to include "ENT-2JHP5A593QSW"
      end
  end
end
