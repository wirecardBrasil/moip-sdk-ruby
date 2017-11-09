module Moip2
  class WebhooksApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path
      "/v2/webhooks"
    end

    def find_all
      Resource::Webhooks.new(client, client.get(base_path.to_s))
    end

    def show(resource_id)
      show_webhook_path = "#{base_path}?resourceId=#{resource_id}"
      Resource::Webhooks.new(client, client.get(show_webhook_path))
    end
  end
end
