module Moip2
	class WebhooksApi
		attr_reader :client
		
		def initialize(client)
			@client = client
		end
		
		def base_path
			"/v2/webhooks"
		end
		
		def show
			Resource::Webhooks.new(client, client.get("#{base_path}"))
		end
	end
end