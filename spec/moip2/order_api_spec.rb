describe Moip2::OrderApi do

  let(:order_api) { described_class.new(sandbox_client)  }

  describe "#create" do

    let(:order) do
      {
        own_id: "your_own_id_1",
        amount: {
          currency: "BRL"
        },
        items: [
          {
            product: "Some Product",
            quantity: 1,
            detail: "Some Product Detail",
            price: 100
          }
        ],
        customer: {
          own_id: "your_customer_own_id",
          fullname: "John Doe",
          email: "john.doe@mailinator.com",
          birthdate: "1988-11-11",
          tax_document: { number: "22222222222", type: "CPF" },
          phone: { country_code: "55", area_code: "11", number: "5566778899" },
          addresses: [
            {
              type: "BILLING",
              street: "Avenida Faria Lima",
              street_number: 2927,
              complement: 8,
              district: "Itaim",
              city: "Sao Paulo",
              state: "SP",
              country: "BRA",
              zip_code: "01234000"
            }
          ]
        }
      }
    end

    let(:created_order) do
      VCR.use_cassette("create_order_success") do
        order_api.create(order)
      end
    end

    it "creates an order on moip" do
      expect(created_order.id).to_not be_nil
      expect(created_order.own_id).to eq("your_own_id_1")
    end

    it "returns an Order object" do
      expect(created_order).to be_a(Moip2::Resource::Order)
    end

    context "when validation error" do

      let(:created_order) do
        VCR.use_cassette("create_order_fail") do
          order_api.create({})
        end
      end

      it "returns an error" do
        expect(created_order).to_not be_success
        expect(created_order).to be_client_error
      end

      it "returns an error json" do
        expect(created_order["errors"].size).to eq(2)
        expect(created_order["errors"][0]["code"]).to_not be_nil
        expect(created_order["errors"][0]["path"]).to_not be_nil
        expect(created_order["errors"][0]["description"]).to_not be_nil
      end

    end

  end

  describe "#show" do

    let(:order) do
      VCR.use_cassette("show_order") do
        order_api.show("ORD-EQE16JGCM52O")
      end
    end

    it "returns an order" do
      expect(order["id"]).to eq("ORD-EQE16JGCM52O")
    end

    context "when order not found" do

      let(:order) do
        VCR.use_cassette("show_order_not_found") do
          order_api.show("ORD-INVALID")
        end
      end

      it "raises a NotFound" do
        expect { order }.to raise_error Moip2::NotFoundError
      end

    end

  end

end
