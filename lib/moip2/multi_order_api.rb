module Moip2
  class MultiOrderApi

    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path
      "/v2/multiorders"
    end

    def create(multi_order)
      Resource::MultiOrder.new client, client.post(base_path, multi_order)
    end

    def show(multi_order_id)
      Resource::MultiOrder.new client, client.get("#{base_path}/#{multi_order_id}")
    end

  end
end