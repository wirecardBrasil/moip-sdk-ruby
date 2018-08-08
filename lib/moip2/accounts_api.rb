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

    def exists?(data)
      raise "Use: {email: 'dev@moip.com'} or {tax_document: '999.999.999-99'}" unless has_attribute_to_search(data)

      response = client.get("#{base_path}/exists?#{to_search(data)}")

      response.success?
    end

    def show(id)
      Resource::Account.new client, client.get("#{base_path}/#{id}")
    end

    private

    def has_attribute_to_search(data)
      data.key?(:tax_document) || data.key?(:email)
    end

    def to_search(data)
      data.key?(:tax_document) ? "tax_document=#{data[:tax_document]}" : "email=#{data[:email]}"
    end
  end
end
