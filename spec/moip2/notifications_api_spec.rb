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

  describe "#create to apps" do
    let (:notification) do
      {
        events: ["ORDER.*", "PAYMENT.AUTHORIZED", "PAYMENT.CANCELLED"],
        target: "http://requestb.in/1dhjesw1",
        media: "WEBHOOK",
      }
    end

    let(:notification_created) do
      VCR.use_cassette("create_notification_app") do
        notifications_api.create(notification, "APP-Y0YCCJ5P603B")
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

  describe "#show" do
    let(:notification_id) { "NPR-1EICPJBCFS4J" }

    let(:notification) do
      VCR.use_cassette("get_notification") do
        notifications_api.show(notification_id)
      end
    end

    it { expect(notification.id).to eq notification_id }
    it { expect(notification.media).to eq "WEBHOOK" }
    it { expect(notification.target).to eq "http://requestb.in/1dhjesw1" }
    it { expect(notification.events).to eq ["ORDER.*", "PAYMENT.AUTHORIZED", "PAYMENT.CANCELLED"] }
    it { expect(notification.token).to eq "5877e87109cc4ef6ae9b1a181cf8a276" }
  end

  describe "#find all" do
    let(:notifications) do
      VCR.use_cassette("get_notifications_list") do
        notifications_api.find_all
      end
    end

    it { expect(notifications).to be_a(Moip2::Resource::Notification) }
    it { expect(notifications).to_not be_nil }
    it { expect(notifications[0]["media"]).to eq "WEBHOOK" }
    it { expect(notifications[0]["target"]).to eq "pandaofertas.com/receive/receiver.php" }
  end

  describe "#delete" do
    let(:response) do
      VCR.use_cassette("delete_notification") do
        notifications_api.delete("NPR-NI9P75W67ZK7")
      end
    end

    it { expect(response).to eq true }
  end

  describe "#delete nonexistent notification" do
    let(:response) do
      VCR.use_cassette("delete_nonexistent_notification") do
        notifications_api.delete("NPR-NI9P75W68ZK7")
      end
    end

    it { expect { response }.to raise_error(Moip2::NotFoundError) }
  end
end
