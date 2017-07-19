module Moip2
  module Resource
    class Order < SimpleDelegator
      attr_reader :client, :payment_api, :external_id

      def initialize(client, response)
        super(response)
        @client = client

        if response.respond_to?(:external_id)
          @payment_api = PaymentApi.new(client)
          @external_id = response.external_id
        end
      end

      def create_payment(payment)
        payment_api.create(external_id, payment)
      end
    end
  end
end
