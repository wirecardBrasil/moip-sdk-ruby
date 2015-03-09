module Moip2
  module Auth

    class OAuth
      def initialize(oauth)
        @oauth = oauth
      end

      def header
        return @oauth if @oauth.start_with? "OAuth"

        %(OAuth #{@oauth})
      end

    end

  end
end
