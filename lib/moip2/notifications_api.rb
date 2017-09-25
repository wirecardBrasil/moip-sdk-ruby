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

    def show(notification_id)
      Resource::Notification.new client, client.get("#{base_path}/#{notification_id}")
    end

    def find_all
      Resource::Notification.new client, client.get(base_path)
    end
  end
end
