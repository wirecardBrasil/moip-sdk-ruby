# Tip: This setup section generally goes in other files,
# and you access them in your controllers as globals,
# instead of reinstantiating them every time.
gem "moip2"

auth = Moip2::Auth::Basic.new("TOKEN", "SECRET")

client = Moip2::Client.new(:sandbox, auth)

api = Moip2::Api.new(client)

# Here we build the order data. You'll get the data from your database
# given your controller input, but here we simplify things with a hardcoded
# example

order = api.order.create(
  own_id: "meu_id_de_order_#{SecureRandom.hex(10)}",
  items: [
    {
      product: "Nome do produto",
      quantity: 1,
      detail: "Mais info...",
      price: 1000,
    },
  ],
  customer: {
    ownId: "meu_cliente_id_#{SecureRandom.hex(10)}",
    fullname: "Integração Moip",
    email: "integracaomoip@moip.com.br",
    taxDocument: {
      type: "CPF",
      number: "22222222222",
    },
    phone: {
      countryCode: "55",
      areaCode: "11",
      number: "66778899",
    },
    shippingAddress: {
      city: "Sao Paulo",
      complement: "8",
      district: "Itaim",
      street: "Avenida Faria Lima",
      streetNumber: "2927",
      zipCode: "01234000",
      state: "SP",
      country: "BRA",
    },
  },
)

# Now with the order ID in hands, you can start creating payments.
# Here is an example of creating a boleto payment:
payment = api.payment.create(
  order.id, funding_instrument: {
    method: "BOLETO",
    boleto: {
      expirationDate: "2020-01-01",
      instructionLines: {
        first: "First line of instructions",
        second: "Second line of instructions",
        third: "Third line of instructions",
      },
    },
  }
)

# This is how you get the boleto from the payment response and be able to show
# it in your checkout
boleto = payment[:_links][:pay_boleto][:print_href]

# Example of getting boleto line code
boleto_line_code = payment[:funding_instrument][:boleto][:line_code]

# This is how you can create a boleto refund to a bank account:
boleto_refund = api.refund.create(
  order.id, refundingInstrument: {
    method: "BANK_ACCOUNT",
    bankAccount: {
      bankNumber: "237",
      agencyNumber: "12345",
      agencyCheckNumber: "0",
      accountNumber: "12345678",
      accountCheckNumber: "7",
      type: "CHECKING",
      holder: {
        taxDocument: {
          type: "CPF",
          number: "22222222222",
        },
        fullname: "Demo Moip",
      },
    },
  }
)

# TIP: To get your application synchronized to Moip's platform,
# you should have a route that handles Webhooks.
# For further information on the possible webhooks, please refer to the official docs
# (https://dev.moip.com.br/v2.0/reference#lista-de-webhooks-disponíveis)
