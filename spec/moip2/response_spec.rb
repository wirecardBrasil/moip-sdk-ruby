describe Moip2::Response do

  let(:parsed_json) { { "id" => "ORD-SOMETHING" } }

  let(:response) { described_class.new(nil, parsed_json) }

  describe "method delegation" do

    it "delegates []" do
      expect(response["id"]).to eq("ORD-SOMETHING")
    end

  end

  describe "#success?" do

    let(:success_response) do
      double("Success Response").tap do |success_response|
        allow(success_response).to receive(:code).and_return(200)
      end
    end

    let(:response) { described_class.new(success_response, parsed_json) }

    it "returns true when response code == 2xx" do
      expect(response).to be_success
    end

  end

end
