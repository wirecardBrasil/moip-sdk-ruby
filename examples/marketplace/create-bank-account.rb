# We are going to create an oauth access token.
# In order to create an oauth acess token, you must create an application on Moip.
# Click on this link to go to Moip's dev docs and create your app:
# https://dev.moip.com.br/v2.0/reference#criar-um-app

gem "moip2"

# In order to create an bank account, you need to log in using the app oauth:
auth = Moip2::Auth::OAuth.new("502f9ca0eccc451dbcf8c0b940110af1_v2")

client = Moip2::Client.new(:sandbox, auth)

api = Moip2::Api.new(client)

# Now you must require permission access for creating bank acount:
api.connect.authorize_url("APP-DVLBF0ANBO1S", "https://meusite.com", "MANAGE_ACCOUNT_INFO,RETRIEVE_FINANCIAL_INFO,TRANSFER_FUNDS")
# Read more here: https://dev.moip.com.br/v2.0/reference#solicitar-permissao

# Once the seller has granted your required accesses, you use the code from
# the response to generate the accessToken used to create a bank account.

# Generate acessToken:
response = api.connect.authorize(
  client_id: "APP-DVLBF0ANBO1S",
  client_secret: "c804485ada664970884149a98816b44e",
  code: "226484a2d081bf49ab82a50d38f8226faca6c9ba",
  redirect_uri: "https://meusite.com",
  grant_type: "authorization_code",
)

# Get accessToken:
response[:access_token]

# Get Moip Account id:
response[:moip_account][:id]

# Now log in using the new accessToken:
auth = Moip2::Auth::OAuth.new("f231cd0328104a58ac1e30a44d51962a_v2")

client = Moip2::Client.new(:sandbox, auth)

api = Moip2::Api.new(client)

# Create a bank account
bank_account = api.bank_accounts.create("MPA-14C9EE706C55",
      bankNumber: "237",
      agencyNumber: "12345",
      agencyCheckNumber: "0",
      accountNumber: "12345678",
      accountCheckNumber: "7",
      type: "CHECKING",
      holder: {
        taxDocument: {
          type: "CPF",
          number: "164.664.426-32",
        },
        fullname: "Sales Machine da Silva",
      })

# Get informations of a bank account
api.bank_accounts.show(bank_account.id)

# Show all bank accounts
api.bank_accounts.find_all("MPA-14C9EE706C55")

# Update a bank account
api.bank_accounts.update("BKA-DWTSK16UQI9N",
      bankNumber: "237",
      agencyNumber: "12345",
      agencyCheckNumber: "0",
      accountNumber: "87654323",
      accountCheckNumber: "7",
      type: "CHECKING",
      holder: {
        taxDocument: {
          type: "CPF",
          number: "164.664.426-32",
        },
        fullname: "Sales Machine da Silva",
      })

# Delete a bank account
api.bank_accounts.delete("BKA-DWTSK16UQI9N")
