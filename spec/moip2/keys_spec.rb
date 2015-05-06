describe Moip2::KeysApi do
	
	let(:keys_api) { described_class.new sandbox_oauth_client }
	
	describe "#show" do
		
		let(:keys) do
			VCR.use_cassette("get_keys") do
				keys_api.show
			end
		end
		
		context 'when shooting request' do
			it { expect(keys).not_to be_nil }
			it { expect(keys.keys.basic_auth.secret).to eq "ABABABABABABABABABABABABABABABABABABABAB" }
			it { expect(keys.keys.basic_auth.token).to eq "01010101010101010101010101010101"}
		end
	end
	
end