describe Moip2::BankAccountsApi do
  let(:bank_accounts_api) { described_class.new sandbox_client }

  describe "#create" do
    context "when given an existent moip account" do
      let(:bank_account) do
        {
          bank_number: "237",
          agency_number: "12345",
          agency_check_number: "0",
          account_number: "12345678",
          account_check_number: "7",
          type: "CHECKING",
          holder: {
            tax_document: {
              type: "CPF",
              number: "255.328.259-12",
            },
            fullname: "Jose Silva dos Santos",
          },
        }
      end

      let(:created_bank_account) do
        VCR.use_cassette("bank_account_create_sucess") do
          bank_accounts_api.create("MPA-CULBBYHD11", bank_account)
        end
      end

      it "creates an bank_account accordingly" do
        expect(created_bank_account.id).to_not be_nil
        expect(created_bank_account.agency_number).to eq("12345")
        expect(created_bank_account.holder.tax_document.number).to eq("255.328.259-12")
        expect(created_bank_account.holder.tax_document.type).to eq("CPF")
        expect(created_bank_account.holder.fullname).to eq("Jose Silva dos Santos")
        expect(created_bank_account.account_number).to eq("12345678")
        expect(created_bank_account.account_check_number).to eq("7")
        expect(created_bank_account.bank_name).to_not be_nil
        expect(created_bank_account.agency_check_number).to eq("0")
        expect(created_bank_account.bank_number).to eq("237")
      end
    end

    context "when given a nonexistent moip account" do
      let(:non_created_bank_account) do
        {
          bank_number: "237",
          agency_number: "12345",
          agency_check_number: "0",
          account_number: "12345678",
          account_check_number: "7",
          type: "CHECKING",
          holder: {
            tax_document: {
              type: "CPF",
              number: "255.328.259-12",
            },
            fullname: "Jose Silva dos Santos",
          },
        }
      end

      let(:bank_account) do
        VCR.use_cassette("bank_account_create_fail") do
          bank_accounts_api.create("MPA-F00B4R123456", non_created_bank_account)
        end
      end

      it { expect(bank_account.response.code).to eq("401") }
    end
  end

  describe "#show" do
    context "when given an existent bank_account" do
      let(:bank_account) do
        VCR.use_cassette("bank_account_show_existent") do
          bank_accounts_api.show("BKA-YBG1D8FKXXMT")
        end
      end

      it "shows an the bank_account accordingly" do
        expect(bank_account.id).to_not be_nil
        expect(bank_account.agency_number).to eq("12345")
        expect(bank_account.holder.tax_document.number).to eq("255.328.259-12")
        expect(bank_account.holder.tax_document.type).to eq("CPF")
        expect(bank_account.holder.fullname).to eq("Jose Silva dos Santos")
        expect(bank_account.account_number).to eq("12345678")
        expect(bank_account.account_check_number).to eq("7")
        expect(bank_account.bank_name).to_not be_nil
        expect(bank_account.agency_check_number).to eq("0")
        expect(bank_account.bank_number).to eq("237")
      end
    end

    context "when given a nonexistent account" do
      let(:bank_account) do
        VCR.use_cassette("bank_account_show_nonexistent") do
          bank_accounts_api.show("BKA-F00B4R123456")
        end
      end

      it { expect { bank_account }.to raise_error(Moip2::NotFoundError) }
    end
  end

  describe "#find_all" do
    let(:bank_account) do
      VCR.use_cassette("bank_account_find_all") do
        bank_accounts_api.find_all("MPA-CULBBYHD11")
      end
    end
    it { expect(bank_account.first["id"]).to eq("BKA-EQW51MWMAO22") }
  end

  describe "#update" do
    let(:bank_account) do
      {
        bank_number: "237",
        agency_number: "54321",
        agency_check_number: "0",
        account_number: "12345678",
        account_check_number: "7",
        type: "CHECKING",
        holder: {
          tax_document: {
            type: "CPF",
            number: "255.328.259-12",
          },
          fullname: "Jose Silva dos Santos",
        },
      }
    end

    let(:updated_bank_account) do
      VCR.use_cassette("bank_account_update") do
        bank_accounts_api.update("BKA-QQSVKMC06A6I", bank_account)
      end
    end

    it "returns an bank_account accordingly to the update" do
      expect(updated_bank_account.id).to_not be_nil
      expect(updated_bank_account.agency_number).to eq("54321")
      expect(updated_bank_account.holder.tax_document.number).to eq("255.328.259-12")
      expect(updated_bank_account.holder.tax_document.type).to eq("CPF")
      expect(updated_bank_account.holder.fullname).to eq("Jose Silva dos Santos")
      expect(updated_bank_account.account_number).to eq("12345678")
      expect(updated_bank_account.account_check_number).to eq("7")
      expect(updated_bank_account.bank_name).to_not be_nil
      expect(updated_bank_account.agency_check_number).to eq("0")
      expect(updated_bank_account.bank_number).to eq("237")
    end
  end

  describe "#delete" do
    context "when given an existent bank account" do
      let(:bank_account) do
        VCR.use_cassette("bank_account_deleted_existent") do
          bank_accounts_api.delete("BKA-YBG1D8FKXXMT")
        end
      end
      it { expect(bank_account.response.code).to eq("200") }
    end

    context "when given a nonexistent bank account" do
      let(:bank_account) do
        VCR.use_cassette("bank_account_deleted_nonexistent") do
          bank_accounts_api.delete("BKA-F00B4R123456")
        end
      end
      it { expect { bank_account }.to raise_error(Moip2::NotFoundError) }
    end
  end
end
