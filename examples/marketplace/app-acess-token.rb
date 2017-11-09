# We are going to create an oauth access token.
# In order to create an oauth acess token, you must create an application on Moip.
# Click on this link to go to Moip's dev docs and create your app:
# https://dev.moip.com.br/v2.0/reference#criar-um-app

gem "moip2"

auth = Moip2::Auth::OAuth.new("502f9ca0eccc451dbcf8c0b940110af1_v2")

client = Moip2::Client.new(:sandbox, auth)

api = Moip2::Api.new(client)

# Now you must require permission access:
api.connect.authorize_url("APP-DVLBF0ANBO1S", "https://meusite.com", "RECEIVE_FUNDS, REFUND")
# Read more here: https://dev.moip.com.br/v2.0/reference#solicitar-permissao

# Once the seller has granted your required accesses, you use the code from
# the response to generate the accessToken.

# Generate acessToken:
response = api.connect.authorize(
  client_id: "APP-DVLBF0ANBO1S",
  client_secret: "c804485ada664970884149a98816b44e",
  code: "3530acb9bd3129d4cd8d4fa7cc4e861a7e96307c",
  redirect_uri: "https://meusite.com",
  grant_type: "authorization_code",
)

# Get accessToken:
response[:access_token]

# Get Moip Account id:
response[:moip_account][:id]
