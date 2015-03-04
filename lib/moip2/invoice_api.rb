module Moip2

  class InvoiceApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path
      "/v2/invoices"
    end

    def show(invoice_external_id)
      Resource::Invoice.new client, client.get("#{base_path}/#{invoice_external_id}")
    end

    def create(invoice)
      Resource::Invoice.new client, client.post(base_path, invoice)
    end

    def update(invoice_external_id, invoice)
      Resource::Invoice.new client, client.put("#{base_path}/#{invoice_external_id}", invoice)
    end

  end

end
