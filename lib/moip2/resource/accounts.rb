module Moip2
  module Resource

    class Accounts < SimpleDelegator

      attr_reader :account

      def initialize(account, response)
        super(response)
        @account = account
      end

    end

  end
end
