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

    def list(begin_date, end_date)
      find_all(begin_date: begin_date, end_date: end_date)
    end

    def find_all(email: nil, begin_date: nil, end_date: nil, limit: 20, offset: 0, q: nil, filters: nil)

      encoded_filters = Moip2::Util::FiltersEncoder.encode(filters)

      # `URI.encode...` will accept nil params, but they will pollute the URI
      params = {
        email: email,
        begin_date: begin_date,
        end_date: end_date,
        limit: limit,
        offset: offset,
        q: q,
        filters: encoded_filters,
      }.reject { |_, value| value.nil? }

      query_string = URI.encode_www_form(params)

      Resource::Invoice.new(
        client,
        client.get("#{base_path}?#{query_string}"),
      )
    end
  end
end
