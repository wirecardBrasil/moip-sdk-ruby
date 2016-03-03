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
      filters = {
        q: opts[:q],
        begin_date: opts[:begin_date],
        end_date: opts[:end_date],
        status: opts[:status],
        vmin: opts[:vmin],
        vmax: opts[:vmax]
      }
      pagination = {
        limit: opts[:limit],
        offset: opts[:offset]
      }

      return client.get("#{base_path}#{build_url_invoice(hash_filters(filters, pagination))}")
    end

    private
      def build_url_invoice(opts)
        "#{opts[:query_params]}" if opts.include?(:query_params)
      end

      def hash_filters(filters, pagination)
        query_params = URI.encode "#{to_query_params(filters)}&limit=#{pagination[:limit]}&offset=#{pagination[:offset]}"
        { query_params: query_params }
      end

      def to_query_params(params = {})
        query_params = Moip2::QueryParams.new();

        unless params[:q].nil?
          query_params.full_text_search(params[:q].strip)
        end

        unless params[:status].nil?
          query_params.equal("status", params[:status])
        end

        unless params[:begin_date].nil?
          query_params.between("creation_date", params[:begin_date], params[:end_date])
        end

        if !params[:vmin].nil? && !params[:vmax].nil?
          query_params.between("invoice_amount", params[:vmin], params[:vmax])
        else
          unless params[:vmin].nil?
            query_params.ge("invoice_amount", params[:vmin])
          end

          unless params[:vmax].nil?
            query_params.le("invoice_amount", params[:vmax])
          end
        end
        query_params.build_uri()
      end

  end

end
