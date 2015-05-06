module Moip2
	
	module KeysApi
		
		attr_reader :client
		
		def initialize(client)
			@client = client
		end
	
		def base_path
			"/v2/keys"
		end
		
		def show(id)
			Resource::Keys.new client, client.get("#{base_path}/#{id}")
		end
	end
end