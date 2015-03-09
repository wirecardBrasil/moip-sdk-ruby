describe Moip2::Auth::OAuth do
  let(:oauth_with_text) { described_class.new "OAuth d63tz2xwyu0ewrembove4j5cbv2otpd" }
  let(:oauth_without_text) { described_class.new "d63tz2xwyu0ewrembove4j5cbv2otpd" }

  describe ".header" do
    it { expect(oauth_with_text.header).to eq "OAuth d63tz2xwyu0ewrembove4j5cbv2otpd" }
    it { expect(oauth_without_text.header).to eq "OAuth d63tz2xwyu0ewrembove4j5cbv2otpd" }
  end
end
