module Moip2

  class Api
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def order
      Moip2::OrderApi.new(client)
    end

    def payment
      Moip2::PaymentApi.new(client)
    end

    def invoice
      Moip2::InvoiceApi.new client
    end

  end

end
