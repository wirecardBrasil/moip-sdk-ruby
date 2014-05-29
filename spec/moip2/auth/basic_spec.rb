describe Moip2::Auth::Basic do

  let(:basic) { described_class.new('01010101010101010101010101010101', 'ABABABABABABABABABABABABABABABABABABABAB') }

  it "builds authorization header" do
    expect(basic.header).to eq "Basic MDEwMTAxMDEwMTAxMDEwMTAxMDEwMTAxMDEwMTAxMDE6QUJBQkFCQUJBQkFCQUJBQkFCQUJBQkFCQUJBQkFCQUJBQkFCQUJBQg=="
  end

end
