module Moip2
  class OrderApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path
      "/v2/orders"
    end

    def create(order)
      Resource::Order.new client, client.post(base_path, order)
    end

    def show(id)
      Resource::Order.new client, client.get("#{base_path}/#{id}")
    end

    def find_all(limit: nil, offset: nil, filters: nil)
      encoded_filters = Moip2::Util::FiltersEncoder.encode(filters)

      # `URI.encode...` will accept nil params, but they will pollute the URI
      params = {
        limit: limit,
        offset: offset,
        filters: encoded_filters,
      }.reject { |_, value| value.nil? }

      query_string = URI.encode_www_form(params)
      path = "#{base_path}?#{query_string}"
      response = client.get(path)

      # We need to transform raw JSON in Order objects
      order_objects = response.orders.map { |order| Resource::Order.new client, order }
      response.orders = order_objects
      Resource::Order.new client, response
    end
  end
end
