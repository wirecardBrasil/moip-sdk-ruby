describe Moip2::WebhooksApi do
	let(:webhooks_api) { described_class.new sandbox_oauth_client }
	
	describe "#show" do
		
		let(:get_webhooks) do
			VCR.use_cassette("get_webhooks") do
				webhooks_api.show
			end
		end
		
		context 'when shooting request by webhooks' do
			it { expect(get_webhooks.webhooks[0][:id]).not_to be_nil }
			it { expect(get_webhooks.webhooks[0][:resource_id]).to eq "ORD-2M8Q09MMCCE2" }
			it { expect(get_webhooks.webhooks[0][:event]).to eq "ORDER.PAID" }
			it { expect(get_webhooks.webhooks[0][:url])	.to eq "http://www.100escolha.com/moip_suporte/" }
			it { expect(get_webhooks.webhooks[0][:status]).to eq "CREATED" }
			it { expect(get_webhooks.webhooks[0][:sent_at]).to eq "May 13, 2015 7:09:06 PM" }
		end
		
	end

end