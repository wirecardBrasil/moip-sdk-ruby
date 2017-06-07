describe Moip2::AccountsApi do

  let(:accounts_api) { described_class.new(account_sandbox_client) }

  describe "#create account" do

    let(:account) do
    {
      email: {
        address: "mail.example@labs.moip.com.br"
      },

      person: {
        name: "Runscope",
        lastName: "Random 9123",
        taxDocument: {
            type: "CPF",
            number: "052.783.271-54"
        },

        identityDocument: {
          type: "RG",
          number: "434322344",
          issuer: "SSP",
          issueDate: "2000-12-12"
        },

        birthDate: "1990-01-01",

        phone: {
            countryCode: "55",
            areaCode: "11",
            number: "965213244"
        },

        address: {
            street: "Av. Brigadeiro Faria Lima",
            streetNumber: "2927",
            district: "Itaim",
            zipCode: "01234-000",
            city: "São Paulo",
            state: "SP",
            country: "BRA"
        }
     },
     type: "MERCHANT"
    }
    end


    let(:created_account) do
      VCR.use_cassette("account") do
        accounts_api.create account
      end
    end

    it { expect(created_account.access_token).to_not be_nil }
    it { expect(created_account.person).to_not be_nil }
    it { expect(created_account.person[:identity_document]).to_not be_nil }
    it { expect(created_account.person[:address]).to_not be_nil }
    it { expect(created_account.person[:phone]).to_not be_nil }
    it { expect(created_account.email).to_not be_nil }
    it { expect(created_account.email).to_not be_nil }
    it { expect(created_account._links[:set_password][:href]).to_not be_nil }
    it { expect(created_account._links[:self][:href]).to_not be_nil }
    it { expect(created_account.id).to eq "MPA-7A87A7AA1C0F" }
    it { expect(created_account.channel_id).to eq "APP-MOIPSANDBOXX" }
    it { expect(created_account.login).to eq "mail.example@labs.moip.com.br" }
    it { expect(created_account.type).to eq "MERCHANT" }
  end
end
