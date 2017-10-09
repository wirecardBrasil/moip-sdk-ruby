module Moip2
  class BalancesApi
    attr_reader :client

    def initialize(client)
      client.opts[:headers]["Accept"] = "application/json;version=2.1"
      @client = client
    end

    def base_path
      "/v2/balances"
    end

    def show
      Resource::Balances.new(client, client.get(base_path))
    end
  end
end
