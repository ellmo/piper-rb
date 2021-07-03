context "configured vs default options" do
  subject { service.call }

  let(:service) { described_class.new }

  describe SuccesfulNilService do
    it { expect(subject).to be_success }
    it { expect(subject.success).to be_nil }
  end

  describe ConfiguredService do
    it { expect(subject).to be_failure }

    it "returns exception" do
      expect(subject.failure[:object]).to be_a StandardError
      expect(subject.failure[:message]).to eq "Here's Johnny!"
    end
  end
end
