module Moip2

  class Api
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def order
      Moip2::OrderApi.new(client)
    end

  end

end
