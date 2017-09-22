module Moip2
  class NotificationPreferenceApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path
      "/v2/preferences/notifications"
    end

    def base_path_for_app(app_id)
      "/v2/preferences/#{app_id}/notifications"
    end

    def create(notification_preference)
      Resource::NotificationPreference.new client, client.post(base_path, notification_preference)
    end

    def create_for_app(notification_preference, app_id)
      Resource::NotificationPreference.new client, client.post(base_path_for_app(app_id), notification_preference)
    end

    def show(id)
      Resource::NotificationPreference.new client, client.get("#{base_path}/#{id}")
    end

    def delete(id)
      Resource::NotificationPreference.new client, client.delete("#{base_path}/#{id}")
    end

    def all
      Resource::NotificationPreference.new client, client.get(base_path)
    end

  end
end
