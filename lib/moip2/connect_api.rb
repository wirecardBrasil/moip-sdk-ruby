module Moip2
  class ConnectApi
    attr_reader :client

    CONNECT_SANDBOX = "connect-sandbox.moip.com.br".freeze
    CONNECT_PRODUCTION = "connect.moip.com.br".freeze

    def initialize(client)
      @client = client
    end

    def authorize_url(client_id, redirect_uri, scope)
      host = client.production? ? CONNECT_PRODUCTION : CONNECT_SANDBOX
      URI::HTTPS.build(
        host:  host,
        path:  "/oauth/authorize",
        query: URI.encode_www_form(
          response_type: "code",
          client_id: client_id,
          redirect_uri: redirect_uri,
          scope: scope,
        ),
      ).to_s
    end

    def authorize(connect)
      Resource::Connect.new client.post(
        "/oauth/token",
        connect,
        "application/x-www-form-urlencoded",        
      )
    end
  end
end
