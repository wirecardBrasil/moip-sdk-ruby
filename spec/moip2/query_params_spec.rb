describe Moip2::QueryParams do

  subject do
    Moip2::QueryParams.new
  end

  describe "#full_text_search" do
    let(:query) { "teste" }
    it{ expect(subject.full_text_search(query)).to eq "q=teste" }
  end

  describe "#equal" do
    context "one" do
      let(:key) { "status" }
      let(:value) { "DELIVERED" }
      it{ expect(subject.equal(key, value)).to eq ["status::eq(DELIVERED)"] }
    end

    context "two" do
      let(:key) { "status" }
      let(:value) { ["DELIVERED","WAITING"] }
      it{ expect(subject.equal(key, value)).to eq ["status::in(DELIVERED,WAITING)"] }
    end
  end

  describe "#ge" do
    let(:key) { "invoice_amount" }
    let(:value) { "1234" }
    it{ expect(subject.ge(key, value)).to eq ["invoice_amount::ge(1234)"] }
  end

  describe "#le" do
    let(:key) { "invoice_amount" }
    let(:value) { "1234" }
    it{ expect(subject.le(key, value)).to eq ["invoice_amount::le(1234)"] }
  end

  describe "#between" do
    let(:key) { "invoice_amount" }
    let(:range_ini) { "1234" }
    let(:range_end) { "2345" }
    it{ expect(subject.between(key, range_ini, range_end)).to eq ["invoice_amount::bt(1234,2345)"] }
  end

  describe "#build_uri" do
    subject do
      query_params = Moip2::QueryParams.new
      query_params.ge("invoice_amount", "234")
      query_params.equal("status", "DELIVERED")
      query_params.full_text_search("não")
      query_params
    end
    it{ expect(subject.build_uri).to eq "?filters=invoice_amount::ge(234)|status::eq(DELIVERED)&q=não" }
  end

end
