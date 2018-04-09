module Moip2
  class TransferApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def create(transfer)
      Resource::Transfer.new client.post(base_path, transfer)
    end

    def show(transfers_id)
      Resource::Transfer.new client.get("#{base_path}/#{transfers_id}")
    end

    def find_all(limit: nil, offset: nil, filters: nil, status: nil)
      response = client.get(uri_encode(limit, offset, filters, status))
      Resource::Transfer.new json_to_object(response)
    end

    def reverse(transfers_id)
      Resource::Transfer.new client.post("#{base_path}/#{transfers_id}/reverse", nil)
    end

    private

    def base_path
      "/v2/transfers"
    end

    def uri_encode(limit, offset, filters, status)
      encoded_filters = Moip2::Util::FiltersEncoder.encode(filters)

      params = {
        limit: limit,
        offset: offset,
        filters: encoded_filters,
        status: status,
      }.reject { |_, value| value.nil? }
      query_string = URI.encode_www_form(params)
      path = "#{base_path}?#{query_string}"
    end

    def json_to_object(json)
      json.transfers.map! { |transfer| Resource::Transfer.new transfer }
      json
    end
  end
end
