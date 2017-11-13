describe Moip2::WebhooksApi do
  let(:webhooks_api) { described_class.new sandbox_oauth_client }

  describe "#show" do
    let(:get_webhooks) do
      VCR.use_cassette("get_webhooks") do
        webhooks_api.show("PAY-6B66XQW6CZHH")
      end
    end

    context "when shooting request by webhooks" do
      it { expect(get_webhooks.webhooks[0][:id]).not_to be_nil }
      it { expect(get_webhooks.webhooks[0][:resource_id]).to eq "PAY-6B66XQW6CZHH" }
      it { expect(get_webhooks.webhooks[0][:event]).to eq "PAYMENT.SETTLED" }
      it { expect(get_webhooks.webhooks[0][:url])	.to eq "http://requestb.in/" }
      it { expect(get_webhooks.webhooks[0][:status]).to eq "CREATED" }
      it { expect(get_webhooks.webhooks[0][:sent_at]).to eq "2017-11-12T02:20:49.269Z" }
    end
  end

  describe "#find_all" do
    let(:get_webhooks) do
      VCR.use_cassette("find_all_webhooks") do
        webhooks_api.find_all
      end
    end

    context "when shooting request by webhooks" do
      it { expect(get_webhooks.webhooks[0][:id]).not_to be_nil }
      it { expect(get_webhooks.webhooks[0][:resource_id]).to eq "ORD-2M8Q09MMCCE2" }
      it { expect(get_webhooks.webhooks[0][:event]).to eq "ORDER.PAID" }
      it { expect(get_webhooks.webhooks[0][:url])	.to eq "http://www.100escolha.com/moip_suporte/" }
      it { expect(get_webhooks.webhooks[0][:status]).to eq "CREATED" }
      it { expect(get_webhooks.webhooks[0][:sent_at]).to eq "May 13, 2015 7:09:06 PM" }
    end
  end

end
