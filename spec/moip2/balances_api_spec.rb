describe Moip2::BalancesApi do
  let(:balances_api) { described_class.new sandbox_oauth_client }

  describe "#show" do
    let(:balances) do
      VCR.use_cassette("get_balances") do
        balances_api.show
      end
    end

    it {
      expect(balances).to have_attributes(
        unavailable: be_an(Array),
        future: be_an(Array),
        current: be_an(Array),
      )
    }
    it { expect(balances.unavailable.first).to have_attributes(amount: be_a(Numeric), currency: be_a(String)) }
    it { expect(balances.future.first).to have_attributes(amount: be_a(Numeric), currency: be_a(String)) }
    it { expect(balances.current.first).to have_attributes(amount: be_a(Numeric), currency: be_a(String)) }
  end
end
