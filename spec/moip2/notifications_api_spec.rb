describe Moip2::NotificationsApi do
  let(:notifications_api) { described_class.new(sandbox_client) }

  describe "#create" do
    let (:notification) do
      {
        events: ["ORDER.*", "PAYMENT.AUTHORIZED", "PAYMENT.CANCELLED"],
        target: "http://requestb.in/1dhjesw1",
        media: "WEBHOOK",
      }
    end

    let(:notification_created) do
      VCR.use_cassette("create_notification") do
        notifications_api.create(notification)
      end
    end

    it { expect(notification_created.id).to_not be_nil }
    it { expect(notification_created.media).to eq "WEBHOOK" }
    it { expect(notification_created.target).to eq "http://requestb.in/1dhjesw1" }
    it {
      expect(notification_created.events).to (
        eq ["ORDER.*", "PAYMENT.AUTHORIZED", "PAYMENT.CANCELLED"]
      )
    }
    it { expect(notification_created.token).to_not be_nil }
  end
end
