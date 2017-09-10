module Moip2
  class NotificationPreferenceApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path
      "/v2/preferences/notifications"
    end

    def create(notification_preference)
      Resource::NotificationPreference.new client, client.post(base_path, notification_preference)
    end

    def show(id)
      Resource::NotificationPreference.new client, client.get("#{base_path}/#{id}")
    end

    def delete(id)
      Resource::NotificationPreference.new client, client.delete("#{base_path}/#{id}")
    end

    def find_all
      Resource::NotificationPreference.new client, client.get(base_path.to_s)
    end

  end
end
