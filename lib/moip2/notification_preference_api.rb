module Moip2
  class NotificationPreferenceApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path(app_id = nil)
      if app_id.nil?
        "/v2/preferences/notifications"
      else
        "/v2/preferences/#{app_id}/notifications"
      end
    end

    def create(notification_preference, app_id = nil)
      Resource::NotificationPreference.new client, client.post(base_path(app_id), notification_preference)
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
