module Moip2
  module Resource
    class Refund < SimpleDelegator
      attr_reader :client, :multi_payment_api, :external_id

      def initialize(client, response)
        super(response)
        @client = client
      end
    end
  end
end
