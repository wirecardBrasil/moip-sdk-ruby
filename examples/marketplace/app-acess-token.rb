# We are going to create an oauth access token.
# In order to create an oauth acess token, you must create an application on Moip.
# Click on this link to go to Moip's dev docs and create your app:
# https://dev.moip.com.br/v2.0/reference#criar-um-app

gem "moip2"

auth = Moip2::Auth::OAuth.new("oauth")

client = Moip2::Client.new(:sandbox, auth)

api = Moip2::Api.new(client)

# Now you must require permission access:
api.connect.authorize_url("APP-DVLBF0ANBO1S", "https://meusite.com", "RECEIVE_FUNDS, REFUND")
# Read more here: https://dev.moip.com.br/v2.0/reference#solicitar-permissao

# Once the seller has granted your required accesses, you use the code from
# the response to generate the accessToken.

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
