describe Moip2::Auth::Basic do
  let(:basic) do
    described_class.new(
      "01010101010101010101010101010101",
      "ABABABABABABABABABABABABABABABABABABABAB",
    )
  end

  it "builds authorization header" do
    expect(basic.header).to eq "Basic MDEwMTAxMDEwMTAxMDEwMTAxMDEwMTAxMDEwMTAxMDE6QUJBQkFCQUJBQkF"\
                               "CQUJBQkFCQUJBQkFCQUJBQkFCQUJBQkFCQUJBQg=="
  end
end
