module Moip2
  class TransferApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def create(order_id, transfer)
      Resource::Payment.new client.post("/v2/transfers", transfer)
    end

    def show(transfers_id)
      Resource::Payment.new client.get("/v2/transfers/#{transfers_id}")
    end

    def reverse(transfers_id)
      Resource::Payment.new client.post("/v2/transfers/#{transfers_id}/reverse", nil)
    end
  end
end
