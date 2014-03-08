describe Moip2::Api do

  let(:api) { described_class.new(:sandbox, token: "01010101010101010101010101010101", secret: "ABABABABABABABABABABABABABABABABABABABAB") }

  describe "#order" do

    it "returns an OrderApi" do
      expect(api.order).to be_a(Moip2::OrderApi)
    end

  end

  # describe "#create_order" do

  #   let(:order) do
  #     Moip2::Order.new(
  #       own_id: "your_own_id_1",
  #       items: [
  #         Moip2::Item.new(
  #           product: "Some Product",
  #           quantity: 1,
  #           detail: "Some Product Detail",
  #           price: 100
  #         )
  #       ],
  #       customer: Moip2::Customer.new(
  #         own_id: "your_customer_own_id",
  #         fullname: "John Doe",
  #         email: "john.doe@mailinator.com",
  #         birthdate: "1988-11-11",
  #         tax_document: Moip2::TaxDocument.new("22222222222"),
  #         phone: Moip2::Phone.new("11", "5566778899"),
  #         addresses: [
  #           Moip2::Address.new(
  #             type: "BILLING",
  #             street: "Avenida Faria Lima",
  #             street_number: 2927,
  #             complement: 8,
  #             district: "Itaim",
  #             city: "Sao Paulo",
  #             state: "SP",
  #             country: "BRA",
  #             zip_code: "01234000"
  #           )
  #         ]
  #       )
  #     )
  #   end

  #   it "creates an order on moip" do
  #     api.create_order order
  #   end

  # end

end
