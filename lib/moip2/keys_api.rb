module Moip2
  class KeysApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path
      "/v2/keys"
    end

    def show
      Resource::Keys.new(client, client.get(base_path.to_s))
    end
  end
end
