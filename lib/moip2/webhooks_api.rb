module Moip2
	class WebhooksApi
		attr_reader :client

		def initialize(client)
			@client = client
		end

		def base_path
			"/v2/webhooks"
		end

		def resend(webhook)
			Resource::Webhooks.new client, client.post(base_path, webhook)
		end


		def show(id)
			Resource::Webhooks.new(client, client.get("#{base_path}/#{id}"))
		end

	end
end
