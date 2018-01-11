module Moip2
  class ConnectApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def authorize_url(client_id, redirect_uri, scope)
      URI::HTTPS.build(
        host: client.host,
        path: "/oauth/authorize",
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
