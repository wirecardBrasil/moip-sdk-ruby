# Tip: This setup section generally goes in other files,
# and you access them in your controllers as globals,
# instead of reinstantiating them every time.
gem "moip2"

auth = Moip2::Auth::OAuth.new("oauth")

client = Moip2::Client.new(:sandbox, auth)

api = Moip2::Api.new(client)

# Here we build the multi order data. You'll get the data from your database
# given your controller input, but here we simplify things with a hardcoded
# example.

# In this example, we create a multi order with two orders for two different
# sellers and two different customers, where the first order of the multi order,
# the seller is the primary receiver, and the second one, the seller is the
# secondary receiver.

### coloca um secundário aqui também recebendo uma porcentagem ao invés de fixo
multi_order = api.multi_order.create(
  own_id: "meu_id_de_multi_order_#{SecureRandom.hex(10)}",
  orders: [
    {
      own_id: "meu_id_de_order_#{SecureRandom.hex(10)}",
      items: [
        {
          product: "Produto 1",
          quantity: 1,
          detail: "Mais info...",
          price: 3000,
        },
      ],
      customer: {
        ownId: "id_do_cliente1_#{SecureRandom.hex(10)}",
        fullname: "Joao Sousa",
        email: "joao.sousa@email.com",
        birthDate: "1988-12-30",
        taxDocument: {
          type: "CPF",
          number: "22222222222",
        },
        phone: {
          countryCode: "55",
          areaCode: "11",
          number: "66778899",
        },
        shippingAddress:  {
          street: "Avenida Faria Lima",
          streetNumber: 2927,
          complement: 8,
          district: "Itaim",
          city: "Sao Paulo",
          state: "SP",
          country: "BRA",
          zipCode: "01234000",
        },
      },
      receivers: [
        {
          moipAccount: {
            id: "MPA-D63A62C73A92",
          },
          type: "PRIMARY",
        },
      ],
    },
    {
      own_id: "meu_segundo_id_de_order_#{SecureRandom.hex(10)}",
      items: [
        {
          product: "Produto 2",
          quantity: 1,
          detail: "Mais info...",
          price: 2600,
        },
      ],
      customer: {
        ownId: "id_do_cliente2_#{SecureRandom.hex(10)}",
        fullname: "Joao Sousa",
        email: "joao.sousa@email.com",
        birthDate: "1988-12-30",
        taxDocument: {
          type: "CPF",
          number: "22222222222",
        },
        phone: {
          countryCode: "55",
          areaCode: "11",
          number: "66778899",
        },
        shippingAddress:  {
          street: "Avenida Faria Lima",
          streetNumber: 2927,
          complement: 8,
          district: "Itaim",
          city: "Sao Paulo",
          state: "SP",
          country: "BRA",
          zipCode: "01234000",
        },
      },
      receivers: [
        {
          moipAccount: {
            id: "MPA-D63A62C73A92",
          },
          type: "PRIMARY",
        },
        {
          moipAccount: {
            id: "MPA-HBKKXIFCY1N3",
          },
          type: "SECONDARY",
          amount: {
            fixed: 55,
          },
        },
      ],
    },
    {
      own_id: "meu_terceiro_id_de_order_#{SecureRandom.hex(10)}",
      items: [
        {
          product: "Produto 3",
          quantity: 2,
          detail: "Mais info...",
          price: 4000,
        },
      ],
      customer: {
        ownId: "id_do_cliente3_#{SecureRandom.hex(10)}",
        fullname: "Joao Sousa",
        email: "joao.sousa@email.com",
        birthDate: "1988-12-30",
        taxDocument: {
          type: "CPF",
          number: "22222222222",
        },
        phone: {
          countryCode: "55",
          areaCode: "11",
          number: "66778899",
        },
        shippingAddress:  {
          street: "Avenida Faria Lima",
          streetNumber: 2927,
          complement: 8,
          district: "Itaim",
          city: "Sao Paulo",
          state: "SP",
          country: "BRA",
          zipCode: "01234000",
        },
      },
      receivers: [
        {
          moipAccount: {
            id:  "MPA-HBKKXIFCY1N3",
          },
          type: "PRIMARY",
        },
        {
          moipAccount: {
            id: "MPA-D63A62C73A92",
          },
          type: "SECONDARY",
          amount: {
            percentual: 40,
          },
        },
      ],
    },
  ],
)

# Now with the order ID in hands, you can start creating payments
# It is common to use the `hash` method if you are using client-side
# encryption for card data.
multi_payment = api.multi_payment.create(multi_order.id,
  funding_instrument: {
    method: "BOLETO",
    boleto: {
      expirationDate: "2020-01-01",
      instructionLines: {
        first: "First line of instructions",
        second: "Second line of instructions",
        third: "Third line of instructions",
      },
    },
  })

# TIP: To get your application synchronized to Moip's platform,
# you should have a route that handles Webhooks.
# For further information on the possible webhooks, please refer to the official docs
# (https://dev.moip.com.br/v2.0/reference#lista-de-webhooks-disponíveis)
