describe Moip2::Auth::OAuth do
  let(:oauth_with_text) { described_class.new "OAuth 9fdc242631454d4c95d82e27b4127394_v2" }
  let(:oauth_without_text) { described_class.new "9fdc242631454d4c95d82e27b4127394_v2" }

  describe ".header" do
    it { expect(oauth_with_text.header).to eq "OAuth 9fdc242631454d4c95d82e27b4127394_v2" }
    it { expect(oauth_without_text.header).to eq "OAuth 9fdc242631454d4c95d82e27b4127394_v2" }
  end
end
