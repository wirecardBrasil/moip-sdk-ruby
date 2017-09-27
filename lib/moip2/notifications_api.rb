module Moip2
  class NotificationsApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path(app_id: nil, notification_id: nil)
      ["", "v2", "preferences", app_id, "notifications", notification_id].compact.join("/")
    end

    def create(notification, app_id = nil)
      Resource::Notification.new client, client.post(base_path(app_id: app_id), notification)
    end

    def show(notification_id)
      Resource::Notification.new client, client.get(base_path(notification_id: notification_id))
    end

    def find_all
      Resource::Notification.new client, client.get(base_path)
    end

    def delete(notification_id)
      resp = Resource::Notification.new client, client.delete(
        base_path(notification_id: notification_id),
      )

      resp.success?
    end
  end
end
