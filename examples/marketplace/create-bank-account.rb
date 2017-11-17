# We are going to create an oauth access token.
# In order to create an oauth acess token, you must create an application on Moip.
# Click on this link to go to Moip's dev docs and create your app:
# https://dev.moip.com.br/v2.0/reference#criar-um-app

gem "moip2"

# In order to create an bank account, you need to log in using the app oauth:
auth = Moip2::Auth::OAuth.new("oauth")

client = Moip2::Client.new(:sandbox, auth)

api = Moip2::Api.new(client)

# Now you must require permission access for creating bank acount:
api.connect.authorize_url("APP-DVLBF0ANBO1S", "https://meusite.com", "MANAGE_ACCOUNT_INFO,RETRIEVE_FINANCIAL_INFO,TRANSFER_FUNDS")
# Read more here: https://dev.moip.com.br/v2.0/reference#solicitar-permissao

# Once the seller has granted your required accesses, you use the code from
# the response to generate the accessToken used to create a bank account.

# Generate acessToken:
response = api.connect.authorize(
  client_id: "your_id", # Ex.: APP-DVLBF0ANBO1S
  client_secret: "your_secret",
  code: "your_code",
  redirect_uri: "https://meusite.com",
  grant_type: "authorization_code",
)

# Get accessToken:
response[:access_token]

# Get Moip Account id:
response[:moip_account][:id]

# Now log in using the new accessToken:
auth = Moip2::Auth::OAuth.new("accessToken")

client = Moip2::Client.new(:sandbox, auth)

api = Moip2::Api.new(client)

# Create a bank account
bank_account = api.bank_accounts.create("MPA-14C9EE706C55",
      bank_number: "237",
      agency_number: "12345",
      agency_check_number: "0",
      account_number: "12345678",
      account_check_number: "7",
      type: "CHECKING",
      holder: {
        tax_document: {
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
      bank_number: "237",
      agency_number: "12345",
      agency_check_number: "0",
      account_number: "87654323",
      account_check_number: "7",
      type: "CHECKING",
      holder: {
        tax_document: {
          type: "CPF",
          number: "164.664.426-32",
        },
        fullname: "Sales Machine da Silva",
      })

# Delete a bank account
api.bank_accounts.delete("BKA-DWTSK16UQI9N")
