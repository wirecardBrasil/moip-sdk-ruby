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
      prepare_options(opts, { headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' } })
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

      def prepare_options(custom_options, required_options)
        custom_options.merge!(required_options)
        if custom_options.include?(:moip_auth)

          if custom_options[:moip_auth][:accessToken] && custom_options[:moip_auth][:key]
            custom_options[:basic_auth] = {
              username: custom_options[:moip_auth][:accessToken],
              password: custom_options[:moip_auth][:key]
            }
          elsif oauth? custom_options[:moip_auth][:oauth][:accessToken]
            custom_options[:headers]["Authorization"] = "#{custom_options[:moip_auth][:oauth][:accessToken]}"
          end

          if custom_options[:moip_auth].include?(:sandbox)
            if custom_options[:moip_auth][:sandbox]
              custom_options[:base_uri] = "https://sandbox.moip.com.br/assinaturas/v1"
            else
              custom_options[:base_uri] = "https://api.moip.com.br/assinaturas/v1"
            end
          end

          custom_options.delete(:moip_auth)
        end
        custom_options
      end

  end

end
