require "base64"

module Moip2
  module Auth

    class Basic

      def initialize(token, secret)
        @token, @secret = token, secret
      end

      def header
        %(Basic #{Base64.strict_encode64("#{@token}:#{@secret}")})
      end

    end

  end
end
