describe Moip2::TransferApi do
  let(:transfer_api) { described_class.new(sandbox_client) }

  context "#create" do
    let(:created_transfer) do
      VCR.use_cassette("create_transfer_success") do
        transfer_api.create(
          amount: 500,
          transferInstrument: {
            method: "BANK_ACCOUNT",
            bankAccount: {
              type: "CHECKING",
              bankNumber: "001",
              agencyNumber: "1111",
              agencyCheckNumber: "2",
              accountNumber: "9999",
              accountCheckNumber: "8",
              holder: {
                fullname: "Nome do Portador",
                taxDocument: {
                  type: "CPF",
                  number: "22222222222",
                },
              },
            },
          },
        )
      end
    end

    it "creates a transfer" do
      expect(created_transfer.id).to eq("TRA-4PGNZ7KOFN4G")
    end

    it "returns a Transfer object" do
      expect(created_transfer).to be_a(Moip2::Resource::Transfer)
    end
  end

  describe "#show" do
    let (:transfer_id) { "TRA-4PGNZ7KOFN4G" }

    let(:response) do
      VCR.use_cassette("get_transfer") do
        transfer_api.show(transfer_id)
      end
    end

    it { expect(response.id).to eq transfer_id }

    context "when transfer is not found" do
      let(:response) do
        VCR.use_cassette("get_transfer_not_found") do
          transfer_api.show("TRA-INVALID")
        end
      end

      it "raises a NotFound" do
        expect { response }.to raise_error Moip2::NotFoundError
      end
    end
  end

  describe "#find_all" do
    context "when passing no query params" do
      subject(:response) do
        VCR.use_cassette("find_all_transfers_no_query_params") do
          transfer_api.find_all
        end
      end

      it { expect(response).to be_a(Moip2::Resource::Transfer) }
      it { expect(response.transfers.size).to eq(20) }
      it { expect(response.transfers.first).to be_a(Moip2::Resource::Transfer) }
      it { expect(response.transfers.first.id).to eq("TRA-4PGNZ7KOFN4G") }
    end

    context "when passing limit" do
      subject(:response) do
        VCR.use_cassette("find_all_transfers_limit") do
          transfer_api.find_all(limit: 10)
        end
      end

      it { expect(response).to be_a(Moip2::Resource::Transfer) }
      it { expect(response.transfers.size).to eq(10) }
      it { expect(response.transfers.first).to be_a(Moip2::Resource::Transfer) }
      it { expect(response.transfers.first.id).to eq("TRA-4PGNZ7KOFN4G") }
    end

    context "when passing offset" do
      subject(:response) do
        VCR.use_cassette("find_all_transfers_offset") do
          transfer_api.find_all(offset: 10)
        end
      end

      it { expect(response).to be_a(Moip2::Resource::Transfer) }
      it { expect(response.transfers.size).to eq(20) }
      it { expect(response.transfers.first).to be_a(Moip2::Resource::Transfer) }
      it { expect(response.transfers.first.id).to eq("TRA-CRQBMMRS4XK9") }
    end

    context "when passing status" do
      subject(:response) do
        VCR.use_cassette("find_all_transfers_status") do
          transfer_api.find_all(status: "REQUESTED")
        end
      end

      it { expect(response).to be_a(Moip2::Resource::Transfer) }
      it { expect(response.transfers.size).to eq(20) }
      it { expect(response.transfers.first).to be_a(Moip2::Resource::Transfer) }
      it { expect(response.transfers.first.id).to eq("TRA-4PGNZ7KOFN4G") }
    end

    context "when passing filters" do
      subject(:response) do
        VCR.use_cassette("find_all_transfers_filters") do
          transfer_api.find_all(filters: { "transferInstrument.method": { in: ["BANK_ACCOUNT"] } })
        end
      end

      it { expect(response).to be_a(Moip2::Resource::Transfer) }
      it { expect(response.transfers.size).to eq(20) }
      it { expect(response.transfers.first).to be_a(Moip2::Resource::Transfer) }
      it { expect(response.transfers.first.id).to eq("TRA-4PGNZ7KOFN4G") }
    end

    context "when passing status, limit and offset" do
      subject(:response) do
        VCR.use_cassette("find_all_transfers_multi_params") do
          transfer_api.find_all(status: "REQUESTED",
                                limit: 2,
                                offset: 2)
        end
      end
      it { expect(response).to be_a(Moip2::Resource::Transfer) }
      it { expect(response.transfers.size).to eq(2) }
      it { expect(response.transfers.first).to be_a(Moip2::Resource::Transfer) }
      it { expect(response.transfers.first.id).to eq("TRA-WG7MJCRAILEH") }
    end
  end

  describe "#revert" do
    let (:reverted_transfer) do
      VCR.use_cassette("revert_transfer") do
        transfer_api.reverse("TRA-B0W5FD5FCADG")
      end
    end

    it { expect(reverted_transfer.id).to eq "TRA-B0W5FD5FCADG" }
    it { expect(reverted_transfer.status).to eq "REVERSED" }
  end
end
