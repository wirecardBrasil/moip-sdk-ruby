module Moip2
  class MultiPaymentApi
     attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path(multi_order_id)
      "/v2/multiorders/#{multi_order_id}/multipayments"
    end

    def create(multi_order_id, payment)
      Resource::Payment.new client.post(base_path(multi_order_id), payment)
    end
  end
end