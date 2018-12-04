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

    def find_all(params = {})
      Resource::Entry.new client, client.get("#{base_path}?#{params.to_query}")
    end
  end
end
