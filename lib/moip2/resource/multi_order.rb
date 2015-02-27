module Moip2

  module Resource
    class MultiOrder < SimpleDelegator

      attr_reader :client, :multi_payment_api, :external_id

      def initialize(client, response)
        super(response)
        @client = client

        if response.respond_to?(:external_id)
          @multi_payment_api = MultiPaymentApi.new(client)
          @external_id = response.external_id
        end
      end

      def create_multi_payment(payment)
        multi_payment_api.create
      end

    end
  end

end