module Moip2

  class Response < SimpleDelegator

    def initialize(resp, json)
      super(json)
      @resp = resp
    end

  end

end
