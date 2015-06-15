module Moip2
  class RefundApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path(id)
      "/v2/#{base_resource(id)}/#{id}/refunds"
    end

    def create(id, refund = {})
      Resource::Refund.new client, client.post(base_path(id), refund)
    end

    def show(id)
      Resource::Refund.new client, client.get("/v2/refunds/#{id}")
    end

    private
      def base_resource(id)
        id.start_with?("PAY") ? "payments" : "orders"
      end
  end
end