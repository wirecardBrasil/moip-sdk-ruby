module Moip2
  class EntryApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path
      "/v2/entries"
    end

    def show(id)
      Resource::Entry.new client, client.get("#{base_path}/#{id}")
    end

    def index
      Resource::Entry.new client, client.get("#{base_path}")
    end
  end
end
