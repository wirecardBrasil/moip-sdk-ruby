describe Moip2::RefundApi do
  let(:refund_api) { described_class.new(sandbox_client) }

  describe "#create order refund" do
    describe "refund full" do

      let(:order_refunded) do
        VCR.use_cassette("create_full_order_refunded") do
          refund_api.create("ORD-7JOU41NX4M1S")
        end
      end

      it "refunds the entire amount" do
        expect(order_refunded.status).to eq "COMPLETED"
      end

    end

    describe "partial refund" do
      let(:refunded_order) do
        VCR.use_cassette("create_partial_refunded_order") do
          refund_api.create("ORD-6K8XPJD9O2KH", { amount: 100 })
        end
      end

      it "refunds a partial amount" do
        expect(refunded_order.status).to eq "COMPLETED"
        expect(refunded_order.type).to eq "PARTIAL"
        expect(refunded_order.id).to eq "REF-QW4T48M7NDFH"
      end
    end
  end

  describe "#show" do
    let(:refunded_order) do
      VCR.use_cassette("show_refund") do
        refund_api.show("REF-QW4T48M7NDFH")
      end
    end

    it "shows a refund" do
      expect(refunded_order.status).to eq "COMPLETED"
      expect(refunded_order.type).to eq "PARTIAL"
      expect(refunded_order.id).to eq "REF-QW4T48M7NDFH"
    end
  end
end