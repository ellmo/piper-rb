context "configured vs default options" do
  subject { service.call }

  let(:service) { described_class.new }

  describe SuccesfulNilService do
    it { expect(subject).to be_success }
    it { expect(subject.success).to be_nil }
  end

  describe "options inheritance" do
    describe ParentService do
      it "returns exception" do
        expect(subject).to be_failure
        expect(subject.failure[:object]).to be_a StandardError
        expect(subject.failure[:message]).to eq "Who's your daddy?"
      end
    end

    describe GoodBoyService do
      it "behaves just like its parent" do
        expect(subject).to be_failure
        expect(subject.failure[:object]).to be_a StandardError
        expect(subject.failure[:message]).to eq "Who's your daddy?"
      end
    end

    describe ProdigalSonService do
      it "fails on `nil` immediately" do
        expect(subject).to be_failure
        expect(subject.failure[:object]).to be_nil
        expect(subject.failure[:message]).to be_nil
      end
    end

    describe ProdigalDaughterService do
      it "ends in uncaught exception" do
        expect { subject }.to raise_error(StandardError)
      end
    end
  end
end
