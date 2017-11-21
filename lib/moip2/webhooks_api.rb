module Moip2
  class WebhooksApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def find_all(limit: nil, offset: nil, resource_id: nil, event: nil)
      # `URI.encode...` will accept nil params, but they will pollute the URI
      params = {
        limit: limit,
        offset: offset,
        resourceId: resource_id,
        event: event,
      }.reject { |_, value| value.nil? }

      query_string = URI.encode_www_form(params)
      path = "#{base_path}?#{query_string}"
      response = client.get(path)

      # We need to transform raw JSON in Webhooks objects
      response.webhooks.map! { |webhooks| Resource::Webhooks.new client, webhooks }
      Resource::Webhooks.new client, response
    end

    private

    def base_path
      "/v2/webhooks"
    end
  end
end
