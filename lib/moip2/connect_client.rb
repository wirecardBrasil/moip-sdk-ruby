module Moip2
  class ConnectClient < Client
    def host
      if production?
        "connect.moip.com.br"
      else
        "connect-sandbox.moip.com.br"
      end
    end
  end
end
