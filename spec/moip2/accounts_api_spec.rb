describe Moip2::AccountsApi do
  let(:accounts_api) { described_class.new sandbox_oauth_client }

  describe "#create" do
    describe "standalone account" do
      let(:account) do
        {
          email: {
            address: "dev.moip.1503312362@labs.moip.com.br",
          },
          person: {
            name: "Joaquim José",
            lastName: "Silva Silva",
            taxDocument: {
              type: "CPF",
              number: "572.619.050-54",
            },
            identityDocument: {
              type: "RG",
              number: "35.868.057-8",
              issuer: "SSP",
              issueDate: "2000-12-12",
            },
            birthDate: "1990-01-01",
            phone: {
              countryCode: "55",
              areaCode: "11",
              number: "965213244",
            },
            address: {
              street: "Av. Brigadeiro Faria Lima",
              streetNumber: "2927",
              district: "Itaim",
              zipCode: "01234-000",
              city: "S\u00E3o Paulo",
              state: "SP",
              country: "BRA",
            },
          },
          type: "MERCHANT",
        }
      end

      let(:created_account) do
        VCR.use_cassette("create_account_success_standalone") do
          accounts_api.create(account)
        end
      end

      it "creates an account accordingly" do
        expect(created_account.id).to_not be_nil
        expect(created_account.type).to eq("MERCHANT")
        expect(created_account.transparent_account).to be false
        expect(created_account.person.name).to eq("Joaquim José")
        expect(created_account.person.last_name).to eq("Silva Silva")
      end
    end

    describe "company account" do
      let(:account) do
        {
          email: {
            address: "dev.moip.1503312536@labs.moip.com.br",
          },
          person: {
            name: "Joaquim José",
            lastName: "Silva Silva",
            taxDocument: {
              type: "CPF",
              number: "436.130.670-21",
            },
            identityDocument: {
              type: "RG",
              number: "30.790.138-5",
              issuer: "SSP",
              issueDate: "2000-12-12",
            },
            birthDate: "1990-01-01",
            phone: {
              countryCode: "55",
              areaCode: "11",
              number: "965213244",
            },
            address: {
              street: "Av. Brigadeiro Faria Lima",
              streetNumber: "2927",
              district: "Itaim",
              zipCode: "01234-000",
              city: "S\u00E3o Paulo",
              state: "SP",
              country: "BRA",
            },
          },
          company: {
            name: "ACME Factories",
            businessName: "ACME Inc.",
            taxDocument: {
              type: "CNPJ",
              number: "88127676000191",
            },
            mainActivity: {
              cnae: "82.91-1/00",
              description: "Atividades de cobranças e informações cadastrais",
            },
            openingDate: "2011-01-01",
            phone: {
              countryCode: "55",
              areaCode: "15",
              number: "40028922",
            },
            address: {
              street: "Av. Brig Faria Lima",
              streetNumber: "3064",
              complement: "12o Andar",
              district: "Itaim Bibi",
              zipCode: "01452002",
              city: "São Paulo",
              state: "SP",
              country: "BRA",
            },
          },
          type: "MERCHANT",
        }
      end

      let(:created_account) do
        VCR.use_cassette("create_account_success_company") do
          accounts_api.create(account)
        end
      end

      it "creates an account accordingly" do
        expect(created_account.id).to_not be_nil
        expect(created_account.type).to eq("MERCHANT")
        expect(created_account.transparent_account).to be false
        expect(created_account.person.name).to eq("Joaquim José")
        expect(created_account.person.last_name).to eq("Silva Silva")
        expect(created_account.company.business_name).to eq("ACME Inc.")
        expect(created_account.company.tax_document.number).to eq("88.127.676/0001-91")
      end
    end
  end

  describe "#exists" do
    describe "with a registered tax document" do
      let(:existence_check) do
        VCR.use_cassette("account_exists_for_tax_document") do
          accounts_api.exists?({tax_document: "436.130.670-21"})
        end
      end

      it { expect(existence_check).to be true }
    end

    describe "with a non registered tax document" do
      let(:existence_check) do
        VCR.use_cassette("account_doesnt_exist_for_tax_document") do
          accounts_api.exists?({tax_document: "555.000.123-40"})
        end
      end

      it { expect(existence_check).to be false }
    end

    describe "with a registered email" do
      let(:existence_check) do
        VCR.use_cassette("account_exists_for_email") do
          accounts_api.exists?({email: "dev.moip.1503312536@labs.moip.com.br"})
        end
      end

      it { expect(existence_check).to be true }
    end

    describe "with a non registered email" do
      let(:existence_check) do
        VCR.use_cassette("account_doesnt_exist_for_email") do
          accounts_api.exists?({email: "dev.moip.0123456789@labs.moip.com.br"})
        end
      end

      it { expect(existence_check).to be false }
    end
  end

  describe "#show" do
    context "when given an existent account" do
      let(:retrieved_account) do
        VCR.use_cassette("accounts_show_existent") do
          accounts_api.show("MPA-67C15332EB4A")
        end
      end

      it { expect(retrieved_account.id).to eq("MPA-67C15332EB4A") }
      it { expect(retrieved_account.person.name).to eq("Joaquim") }
      it { expect(retrieved_account.person.last_name).to eq("Silva Silva") }
    end

    context "when given a nonexistent account" do
      let(:retrieved_account) do
        VCR.use_cassette("accounts_show_nonexistent") do
          accounts_api.show("MPA-F00B4R123456")
        end
      end

      it { expect { retrieved_account }.to raise_error(Moip2::NotFoundError) }
    end
  end
end
