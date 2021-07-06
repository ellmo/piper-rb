context "configured vs inline options" do
  subject { described_class.new.call }

  describe InlineOptionsService do
    it "returns exception" do
      expect(subject).to be_failure
      expect(subject.failure[:object]).to be_a StandardError
      expect(subject.failure[:message]).to eq "We are handled inline."
    end
  end

  describe InlineOverrideOneService do
    it "fails on nil" do
      expect(subject).to be_failure
      expect(subject.failure[:object]).to be_nil
    end
  end

  describe InlineOverrideTwoService do
    it "raises exception" do
      expect { subject }.to raise_error(StandardError, "Handling was rescinded.")
    end
  end
end
