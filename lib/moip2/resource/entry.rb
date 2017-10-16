
module Moip2
  module Resource
    class Entry < SimpleDelegator
      attr_reader :client, :entry_api

      def initialize(client, response)
        super(response)
        @client = client
      end
    end
  end
end
