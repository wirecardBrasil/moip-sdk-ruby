describe Moip2::Auth::OAuth do
  let(:oauth_with_text) { described_class.new "OAuth 1tldio91gi74r34zv30d4saz8yuuws5" }
  let(:oauth_without_text) { described_class.new "1tldio91gi74r34zv30d4saz8yuuws5" }

  describe ".header" do
    it { expect(oauth_with_text.header).to eq "OAuth 1tldio91gi74r34zv30d4saz8yuuws5" }
    it { expect(oauth_without_text.header).to eq "OAuth 1tldio91gi74r34zv30d4saz8yuuws5" }
  end
end
