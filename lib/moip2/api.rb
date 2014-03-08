module Moip2

  class Api
    include HTTParty

    headers "Content-Type" => "application/json"

    attr_reader :env, :credentials, :opts

    def initialize(env = :sandbox, credentials = {}, opts = {})
      @env, @credentials, @opts = env, credentials, opts
    end

    def client
      Moip2::Client.new env, credentials, opts
    end

    def order
      Moip2::OrderApi.new(client)
    end

  end

end
