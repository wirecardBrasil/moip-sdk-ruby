module Moip2
  class Client
    include HTTParty

    attr_reader :env, :auth, :uri

    def initialize(env = :sandbox, auth = nil, opts = {})
      @env = env.to_sym
      @auth = auth
      @opts = opts

      @uri = get_base_uri
      self.class.base_uri @uri
    end

    def sandbox?
      env == :sandbox
    end

    def production?
      env == :production
    end

    def opts
      opts = @opts
      opts[:headers] ||= {}

      opts[:headers].merge!(
        "Content-Type" => "application/json",
        "Authorization" => auth.header,
        "User-Agent" => "MoipRubySDK/#{Moip2::VERSION} (+https://github.com/moip/moip-sdk-ruby)",
      )

      opts
    end

    def post(path, resource, content_type = "application/json")
      new_opts = opts
      new_opts[:headers]["Content-Type"] = content_type
      options = new_opts.merge(body: encode_resource(content_type, resource))

      resp = self.class.post path, options
      create_response resp
    end

    def put(path, resource)
      options = opts.merge(body: convert_hash_keys_to(:camel_case, resource).to_json)
      resp = self.class.put path, options

      create_response resp
    end

    def delete(path)
      resp = self.class.delete path, opts

      create_response resp
    end

    def get(path)
      resp = self.class.get path, opts

      create_response resp
    end

    def host
      if production?
        "api-waf.moip.com.br"
      else
        "sandbox.moip.com.br"
      end
    end

    private

    def get_base_uri
      "https://#{host}"
    end

    def create_response(resp)
      raise NotFoundError, "Resource not found" if resp.code == 404

      Response.new resp, convert_hash_keys_to(:snake_case, resp.parsed_response)
    end

    def basic_auth
      { username: @auth[:token], password: @auth[:secret] }
    end

    def convert_hash_keys_to(conversion, value)
      case value
      when Array
        value.map { |v| convert_hash_keys_to(conversion, v) }
      when Hash
        Hash[value.map { |k, v| [send(conversion, k).to_sym, convert_hash_keys_to(conversion, v)] }]
      else
        value
      end
    end

    def encode_resource(content_type, resource)
      return URI.encode_www_form(resource) if content_type == "application/x-www-form-urlencoded"

      convert_hash_keys_to(:camel_case, resource).to_json
    end

    def camel_case(str)
      return str.to_s if str.to_s !~ /_/ && str.to_s =~ /[A-Z]+.*/
      words = str.to_s.split("_")
      (words[0..0] << words[1..-1].map(&:capitalize)).join
    end

    def snake_case(str)
      str.gsub(/::/, "/").
        gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
        gsub(/([a-z\d])([A-Z])/, '\1_\2').
        tr("-", "_").
        downcase
    end
  end
end
