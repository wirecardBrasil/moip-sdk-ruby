describe Moip2::AccountsApi do
  let(:accounts_api) { described_class.new sandbox_oauth_client }

  describe "#create" do
    describe "standalone account" do
      let(:account) do
        {
          email: {
            address: "dev.moip.#{Time.now.to_i}@labs.moip.com.br",
          },
          person: {
            name: "Joaquim José",
            lastName: "Silva Silva",
            taxDocument: {
              type: "CPF",
              number: "960.004.572-00",
            },
            identityDocument: {
              type: "RG",
              number: "434322344",
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
            address: "dev.moip.#{Time.now.to_i}@labs.moip.com.br",
          },
          person: {
            name: "Joaquim José",
            lastName: "Silva Silva",
            taxDocument: {
              type: "CPF",
              number: "960.004.572-00",
            },
            identityDocument: {
              type: "RG",
              number: "434322344",
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
              country: "BR",
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
        expect(created_account.company.tax_document).to eq("88127676000191")
      end
    end
  end
end
