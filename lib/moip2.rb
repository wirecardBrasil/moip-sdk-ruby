require "httparty"
require "delegate"

require "moip2/version"

require "moip2/auth/basic"

require "moip2/response"
require "moip2/client"
require "moip2/order_api"
require "moip2/api"

module Moip2

  class << self

    VALID_ENVS = %i(sandbox production)

    def env=(env)
      raise "Invalid Environment" unless VALID_ENVS.include?(env)
      @env = env
    end

    def env
      @env ||= :sandbox
    end

    def auth=(credentials)
      @credentials = credentials
    end

    def auth
      @credentials ||= {}
    end

    def opts=(opts = {})
      @opts = opts
    end

    def opts
      @opts ||= {}
    end

    def new
      Api.new Client.new(env, auth)
    end

  end

  class NotFoundError < StandardError
  end

end
