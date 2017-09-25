module Moip2
  class NotificationsApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path
      "/v2/preferences/notifications"
    end

    def create(notification)
      Resource::Notification.new client, client.post(base_path, notification)
    end
  end
end
