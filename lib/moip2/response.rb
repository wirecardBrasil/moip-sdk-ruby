module Moip2
  class Response < SimpleDelegator
    def initialize(resp, json)
      super(RecursiveOpenStruct.new(json, recurse_over_arrays: true))
      @resp = resp
    end

    def success?
      (200..299).cover? @resp.code.to_i
    end

    def client_error?
      (400..499).cover? @resp.code.to_i
    end
  end
end
