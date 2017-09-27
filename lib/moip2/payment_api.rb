module Moip2
  class PaymentApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def create(order_id, payment)
      Resource::Payment.new client.post("/v2/orders/#{order_id}/payments", payment)
    end

    def show(payment_id)
      Resource::Payment.new client.get("/v2/payments/#{payment_id}")
    end

    def capture(payment_id)
      Resource::Payment.new client.post("/v2/payments/#{payment_id}/capture", nil)
    end

    def void(payment_id)
      Resource::Payment.new client.post("/v2/payments/#{payment_id}/void", nil)
    end
  end
end
