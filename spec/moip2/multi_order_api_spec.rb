describe Moip2::MultiOrderApi do

  let(:multi_order_api) { described_class.new(sandbox_client) }
  
  describe "#create" do 
    let(:multi_order) do
    {
      ownId: "meu_multiorder_id",
      orders: [
          {
          ownId: "pedido_1_id",
          amount: {
            currency: "BRL",
            subtotals: {
              shipping: 2000
              }
            },
          items: [
              {
              product: "Camisa Verde e Amarelo - Brasil",
              quantity: 1,
              detail: "Seleção Brasileira",
              price: 2000
              }
            ],
          customer: {
            ownId: "customer[1234]",
            fullname: "Joao Sousa",
            email: "joao.sousa@email.com",
            birthDate: "1988-12-30",
            taxDocument: {
              type: "CPF",
              number: "22222222222"
              },
            phone: {
              countryCode: "55",
              areaCode: "11",
              number: "66778899"
              },
            addresses: [
                {
                type: "BILLING",
                street: "Avenida Faria Lima",
                streetNumber: 2927,
                complement: 8,
                district: "Itaim",
                city: "Sao Paulo",
                state: "SP",
                country: "BRA",
                zipCode: "01234000"
                }
              ]
            },
          receivers: [
              {
              moipAccount: {
                id: "MPA-1K2R51KFL3OY"
                },
              type: "PRIMARY"
              }
            ]
          },
          {
          ownId: "pedido_2_id",
          amount: {
            currency: "BRL",
            subtotals: {
              shipping: 3000
              }
            },
          items: [
              {
              product: "Camisa Preta - Alemanha",
              quantity: 1,
              detail: "Camiseta da Copa 2014",
              price: 1000
              }
            ],
          customer: {
            ownId: "customer[1234]",
            fullname: "Joao Sousa",
            email: "joao.sousa@email.com",
            birthDate: "1988-12-30",
            taxDocument: {
              type: "CPF",
              number: "22222222222"
              },
            phone: {
              countryCode: "55",
              areaCode: "11",
              number: "66778899"
              },
            addresses: [
                {
                type: "BILLING",
                street: "Avenida Faria Lima",
                streetNumber: 2927,
                complement: 8,
                district: "Itaim",
                city: "Sao Paulo",
                state: "SP",
                country: "BRA",
                zipCode: "01234000"
                }
              ]
            },
          receivers: [
              {
              moipAccount: {
                id: "MPA-IFYRB1HBL73Z"
                },
              type: "PRIMARY"
              },
              {
              moipAccount: {
                id: "MPA-KQB1QFWS6QNM"
                },
              type: "SECONDARY",
              amount: {
                fixed: 55
                }
              }
            ]
          }
        ]
      } 
    end

    let(:created_multi_order) do
      VCR.use_cassette("create_mulit_order_success") do
        multi_order_api.create(multi_order)
      end
    end

    it "creates a multiOrder on moip" do
      expect(created_multi_order.id).to eq "MOR-IVKZDU55LXJU"
      expect(created_multi_order.own_id).to eq "meu_multiorder_id"
      expect(created_multi_order.status).to eq "CREATED"
      expect(created_multi_order.orders).to_not be_nil
    end

    it "returns an MultiOrder object" do
      expect(created_multi_order).to be_a(Moip2::Resource::MultiOrder)
    end

    context "when validation error" do

      let(:created_multi_order) do
        VCR.use_cassette("create_multi_order_fail") do
          multi_order_api.create({})
        end
      end

      it "returns an error" do
        expect(created_multi_order).to_not be_success
        expect(created_multi_order).to be_client_error
      end

      it "returns an error json" do
        expect(created_multi_order["errors"].size).to eq(1)
        expect(created_multi_order.errors[0].code).to_not be_nil
        expect(created_multi_order.errors[0].path).to_not be_nil
        expect(created_multi_order.errors[0].description).to_not be_nil
      end

    end

  end

  describe "#show" do

    let(:multi_order) do
      VCR.use_cassette("show_multi_order") do
        multi_order_api.show("MOR-IVKZDU55LXJU")
      end
    end

    it "returns an multi order" do
      expect(multi_order["id"]).to eq("MOR-IVKZDU55LXJU")
    end

    context "when multi order not found" do

      let(:multi_order) do
        VCR.use_cassette("show_multi_order_not_found") do
          multi_order_api.show("MOR-INVALID")
        end
      end

      it "raises a NotFound" do
        expect { multi_order }.to raise_error Moip2::NotFoundError
      end

    end

  end

end