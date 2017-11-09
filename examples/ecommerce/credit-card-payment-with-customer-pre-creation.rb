# Tip: This setup section generally goes in other files,
# and you access them in your controllers as globals,
# instead of reinstantiating them every time.
gem "moip2"

auth = Moip2::Auth::Basic.new("JKRRWGJWD0TISDEOPVKMUP7FWPQPKZGC", "ZUEZVC34E4YBHOAJETPJXBHVQBTSIVHTXBN9LTR8")

client = Moip2::Client.new(:sandbox, auth)

api = Moip2::Api.new(client)

# If you want to persist your customer data and save later, now is
# the time to create it.
# TIP: Don't forget to generate your `own_id` or use one you already have

customer = api.customer.create(
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
)

# TIP: Now you can access the Moip ID to save it to your database, if you want
# Ex.:
# Customer.find_by(id: 123).update!(moip_id: customer.id)

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
    id: customer.id,
  },
)

# Now with the order ID in hands, you can start creating payments
# It is common to use the `hash` method if you are using client-side
# encryption for card data.
payment = api.payment.create(order.id,
  installment_count: 1,
  funding_instrument: {
    method: "CREDIT_CARD",
    credit_card: {
      # You can generate the following hash using a Moip Javascript SDK
      # where you use the customer credit_card data and your public key
      # to create the hash.
      # Read more about creating credit card hash here:
      # https://dev.moip.com.br/v2.0/docs/criptografia-de-cartao
      hash: "kJHoKZ2bIVFjEFPSQQxbpXL6t5VCMoGTB4eJ4GLHmUz8f8Ny/LSL20yqbn+bZQymydVJyo3lL2DMT0dsWMzimYILQH4vAF24VwM0hKxX7nVwqGpGCXwBwSJGCwR57lqDiI4RVhKTVJpu7FySfu+Hm9JWSk4fzPXQO/FRqIS5TJQWJSywjLmGwyYtTGsmHTSCwvPFg+0GcG/EkYjPesMc/ycxPixibrEId9Wz03QnLsHYzSBCnPqg8xq8WKYDX2x3dHV3GNsB4TEfVz4psynddDEpX/VhIk2e8cXQ0EoXKkWdJEJB4KFmqj39OhNevCBkF5ADvzFp73J0IxnjOf1AQA==",
      holder: {
        fullname: "Integração Moip",
        birthdate: "1988-12-30",
        taxDocument: {
          type: "CPF",
          number: "33333333333",
        },
        phone: {
          countryCode: "55",
          areaCode: "11",
          number: "000000000",
        },
      },
    },
  })

# You can also use the card data, if you're PCI compliant.
payment = api.payment.create(order.id,
  installment_count: 1,
  funding_instrument: {
    method: "CREDIT_CARD",
    credit_card: {
      expirationMonth: "02",
      expirationYear: "20",
      number: "5555666677778884",
      cvc: "123",
      holder: {
        fullname: "Integração Moip",
        birthdate: "1988-12-30",
        taxDocument: {
          type: "CPF",
          number: "33333333333",
        },
        phone: {
          countryCode: "55",
          areaCode: "11",
          number: "000000000",
        },
      },
    },
  })

# This is how you can create a payment with escrow:
payment = api.payment.create(order.id,
  installment_count: 1,
  escrow: {
    description: "Teste escrow",
  },
  funding_instrument: {
    method: "CREDIT_CARD",
    credit_card: {
      expirationMonth: "02",
      expirationYear: "20",
      number: "5555666677778884",
      cvc: "123",
      holder: {
        fullname: "Integração Moip",
        birthdate: "1988-12-30",
        taxDocument: {
          type: "CPF",
          number: "33333333333",
        },
        phone: {
          countryCode: "55",
          areaCode: "11",
          number: "000000000",
        },
      },
    },
  })

# You can create a full payment refunds:
full_payment_refund = api.refund.create(payment.id)

# Or a partial payment refunds, where the second parameter is
# the value of the refunds:
partial_payment_refund = api.refund.create(payment.id, amount: 2000)

# You can also create full order refund:
full_order_refund = api.refund.create(order.id)

# Or a partial order refund:
partial_order_refund = api.refund.create(order.id, amount: 2000)

# TIP: To get your application synchronized to Moip's platform,
# you should have a route that handles Webhooks.
# For further information on the possible webhooks, please refer to the official docs
# (https://dev.moip.com.br/v2.0/reference#lista-de-webhooks-disponíveis)
