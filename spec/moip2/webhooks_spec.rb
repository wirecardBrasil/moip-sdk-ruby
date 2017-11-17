describe Moip2::WebhooksApi do
  let(:webhooks_api) { described_class.new sandbox_oauth_client }

  describe "#find_all" do
    context "when passing no filters" do
      subject(:response) do
        VCR.use_cassette("find_all_webhooks_no_filter") do
          webhooks_api.find_all
        end
      end

      it { expect(response).to be_a(Moip2::Resource::Webhooks) }
      it { expect(response.webhooks.size).to eq(20) }
      it { expect(response.webhooks.first).to be_a(Moip2::Resource::Webhooks) }
      it { expect(response.webhooks.first.id).to eq("EVE-DYPUJBZLJAPP") }
      it { expect(response.webhooks.first.resource_id).to eq("ORD-2M8Q09MMCCE2") }
      it { expect(response.webhooks.first.event).to eq("ORDER.PAID") }
    end

    context "when passing limit" do
      subject(:response) do
        VCR.use_cassette("find_all_webhooks_limit") do
          webhooks_api.find_all(limit: 10)
        end
      end

      it { expect(response).to be_a(Moip2::Resource::Webhooks) }
      it { expect(response.webhooks.size).to eq(10) }
      it { expect(response.webhooks.first).to be_a(Moip2::Resource::Webhooks) }
      it { expect(response.webhooks.first.id).to eq("EVE-DYPUJBZLJAPP") }
      it { expect(response.webhooks.first.resource_id).to eq("ORD-2M8Q09MMCCE2") }
      it { expect(response.webhooks.first.event).to eq("ORDER.PAID") }
    end

    context "when passing offset" do
      subject(:response) do
        VCR.use_cassette("find_all_webhooks_offset") do
          webhooks_api.find_all(offset: 10)
        end
      end

      it { expect(response).to be_a(Moip2::Resource::Webhooks) }
      it { expect(response.webhooks.size).to eq(20) }
      it { expect(response.webhooks.first).to be_a(Moip2::Resource::Webhooks) }
      it { expect(response.webhooks.first.id).to eq("EVE-NBIW53UT95VL") }
      it { expect(response.webhooks.first.resource_id).to eq("PAY-M1A3GR2L5GF6") }
      it { expect(response.webhooks.first.event).to eq("PAYMENT.AUTHORIZED") }
    end

    context "when passing resource id" do
      subject(:response) do
        VCR.use_cassette("find_all_webhooks_resource_id") do
          webhooks_api.find_all(resource_id: "PAY-REJJ9F12MF7R")
        end
      end

      it { expect(response).to be_a(Moip2::Resource::Webhooks) }
      it { expect(response.webhooks.size).to eq(20) }
      it { expect(response.webhooks.first).to be_a(Moip2::Resource::Webhooks) }
      it { expect(response.webhooks.first.id).to eq("EVE-Y3IHX8P55I6Z") }
      it { expect(response.webhooks.first.resource_id).to eq("PAY-REJJ9F12MF7R") }
      it { expect(response.webhooks.first.event).to eq("PAYMENT.WAITING") }
    end

    context "when passing event" do
      subject(:response) do
        VCR.use_cassette("find_all_webhooks_event") do
          webhooks_api.find_all(event: "PAYMENT.WAITING")
        end
      end

      it { expect(response).to be_a(Moip2::Resource::Webhooks) }
      it { expect(response.webhooks.size).to eq(4) }
      it { expect(response.webhooks.first).to be_a(Moip2::Resource::Webhooks) }
      it { expect(response.webhooks.first.id).to eq("EVE-C3PSMS9LZTSD") }
      it { expect(response.webhooks.first.resource_id).to eq("PAY-XWNRC9MZTCO8") }
    end

    context "when passing event, resource id and limit" do
      subject(:response) do
        VCR.use_cassette("find_all_webhooks_multi_params") do
          webhooks_api.find_all(event: "PAYMENT.WAITING",
                                resource_id: "PAY-REJJ9F12MF7R",
                                limit: 2,
                                offset: 2)
        end
      end
      it { expect(response).to be_a(Moip2::Resource::Webhooks) }
      it { expect(response.webhooks.size).to eq(2) }
      it { expect(response.webhooks.first).to be_a(Moip2::Resource::Webhooks) }
      it { expect(response.webhooks.first.id).to eq("EVE-JLC485YHPXMS") }
      it { expect(response.webhooks.first.resource_id).to eq("PAY-REJJ9F12MF7R") }
      it { expect(response.webhooks.first.event).to eq("PAYMENT.WAITING") }
    end
  end
end
