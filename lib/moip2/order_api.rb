module Moip2

  class OrderApi

    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path
      "/v2/orders"
    end

    def create(order)
      client.post(base_path, order)
    end

    def show(id)
      client.get("#{base_path}/#{id}")
    end

  end

end
