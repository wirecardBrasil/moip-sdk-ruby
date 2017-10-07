# Tip: This setup section generally goes in other files,
# and you access them in your controllers as globals,
# instead of reinstantiating them every time.
gem "moip2"

auth = Moip2::Auth::Basic.new("TOKEN", "SECRET")

client = Moip2::Client.new(:production, auth)

api = Moip2::Api.new(client)

# If you want to persist your customer data and save later, now is
# the time to create it.
# TIP: Don't forget to generate your `own_id` or use one you already have

customer = api.customer.create({
                                 # ...
                               })

# TIP: Now you can access the Moip ID to save it to your database, if you want
# Ex.:
# Customer.find_by(id: 123).update!(moip_id: customer.id)

# Here we build the order data. You'll get the data from your database
# given your controller input, but here we simplify things with a hardcoded
# example

order = api.order.create(
  own_id: SecureRandom.hex(10), # If you've saved the Order to database, you can use the database id
  items: [
    {
      product: "Nome do produto",
      quantity: 1,
      detail: "Mais info...",
      price: 1000,
    },
  ],
  customer: { id: customer.id },
)

# Now with the order ID in hands, you can start creating payments
payment = api.payment.create(order.id,
      installment_count: 1,
      funding_instrument: {
        method: "CREDIT_CARD",
        credit_card: {
          hash: "js_hash", # It is common to use the `hash` method. You can also use the card data, if you're PCI compliant.
          holder: {
            # ...
          },
        },
      })

# TIP: To get your application synchronized to Moip's platform, you should have a route that handles Webhooks.
# For further information on the possible webhooks, please refer to the official docs 
# (https://dev.moip.com.br/v2.0/reference#lista-de-webhooks-disponíveis)
