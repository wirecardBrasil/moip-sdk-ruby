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

    def list(opts={})
      return client.get("#{base_path}#{build_url_invoice(opts)}")
    end

    private
      def oauth?(authorization_hash)
        raise MissingTokenError.new if authorization_hash.nil? || !authorization_hash.downcase.include?("oauth")
        true
      end

      def build_url_invoice(opts)
        "#{opts[:query_params]}" if opts.include?(:query_params)
      end

  end

end
