module Moip2
  class NotificationsApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path
      "/v2/preferences/notifications"
    end

    def base_path_app(app_id)
      "/v2/preferences/#{app_id}/notifications"
    end

    def create(notification, app_id = nil)
      path = app_id == nil ? base_path : base_path_app(app_id)

      Resource::Notification.new client, client.post(path, notification)
    end

    def show(notification_id)
      Resource::Notification.new client, client.get("#{base_path}/#{notification_id}")
    end

    def find_all
      Resource::Notification.new client, client.get(base_path)
    end
  end
end
