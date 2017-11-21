module Moip2
  class BankAccountsApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def create(account_id, bank_account)
      Resource::BankAccount.new client, client.post(
        base_account_path(account_id),
         bank_account,
      )
    end

    def show(bank_account_id)
      Resource::BankAccount.new client, client.get(
        base_bank_account_path(bank_account_id),
      )
    end

    def delete(bank_account_id)
      Resource::BankAccount.new client, client.delete(
        base_bank_account_path(bank_account_id),
      )
    end

    def update(bank_account_id, bank_account)
      Resource::BankAccount.new client, client.put(
        base_bank_account_path(bank_account_id),
        bank_account,
      )
    end

    def find_all(account_id)
      Resource::BankAccount.new client, client.get(
        base_account_path(account_id),
      )
    end

    private

    def base_bank_account_path(bank_account_id)
      "/v2/bankaccounts/#{bank_account_id}"
    end

    def base_account_path(account_id)
      "/v2/accounts/#{account_id}/bankaccounts"
    end
  end
end
