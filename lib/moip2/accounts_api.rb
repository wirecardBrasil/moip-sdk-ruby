module Moip2
  class AccountsApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path
      "/v2/accounts"
    end

    def create(account)
      Resource::Account.new client, client.post(base_path, account)
    end

    def exists?(tax_document = "")
      response = client.get("#{base_path}/exists?tax_document=#{tax_document}")

      response.code.to_i == 200
    end
  end
end
