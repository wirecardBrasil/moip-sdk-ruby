module Moip2
  class AccountsApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path
      "/v2/accounts"
    end
  end
end
