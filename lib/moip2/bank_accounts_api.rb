module Moip2
  class BankAccountsApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path(client_id)
      "/v2/accounts/#{client_id}/bankaccounts"
    end

    def create(account_id, bank_account)
      Resource::BankAccount.new client, client.post(base_path(account_id), bank_account)
    end
  end
end
