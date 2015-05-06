describe Moip2::KeysApi do
	
	describe "#show" do
		
		let(:keys) do
			VCR.use_cassette("get_keys") do
				key_api.show
			end
		end
		
	end
	
end