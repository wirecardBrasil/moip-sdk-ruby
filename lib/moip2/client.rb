module Moip2

  class Client
    include HTTParty

    headers "Content-Type" => "application/json"

    attr_reader :env, :credentials, :opts

    def initialize(env = :sandbox, credentials = {}, opts = {})
      @env, @credentials, @opts = env, credentials, opts

      if sandbox?
        self.class.base_uri "https://test.moip.com.br"
      else
        self.class.base_uri "https://api.moip.com.br"
      end
    end

    def sandbox?
      env == :sandbox
    end

    def post(path, resource)
      options = { body: convert_hash_keys_to(:camel_case, resource).to_json, basic_auth: basic_auth }
      resp = self.class.post path, options

      Response.new resp, convert_hash_keys_to(:snake_case, resp.parsed_response)
    end

    private
    def basic_auth
      { username: @credentials[:token], password: @credentials[:secret]}
    end

    def convert_hash_keys_to(conversion, value)
      case value
        when Array
          value.map { |v| convert_hash_keys_to(conversion, v) }
        when Hash
          Hash[value.map { |k, v| [send(conversion, k), convert_hash_keys_to(conversion, v)] }]
        else
          value
       end
    end

    def camel_case(str)
      return str.to_s if str.to_s !~ /_/ && str.to_s =~ /[A-Z]+.*/
      words = str.to_s.split('_')
      (words[0..0] << words[1..-1].map{|e| e.capitalize}).join
    end

    def snake_case(str)
        str.gsub(/::/, '/').
            gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
            gsub(/([a-z\d])([A-Z])/,'\1_\2').
            tr("-", "_").
            downcase
    end

  end

end
