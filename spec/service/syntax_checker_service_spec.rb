describe SyntaxCheckerService do
  subject { service.call }

  let(:service) { described_class.new(params) }

  context "no arguments passed" do
    subject { described_class.new }

    it "Raises DryStruct`s argument error" do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end

  context "non integer argument passed" do
    let(:params) { { input: 0.5 } }

    it "Raises DryStruct`s argument error" do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end

  context "integer argument passed" do
    let(:params) { { input: 123 } }

    it "returns success" do
      expect(subject).to be_a Dry::Monads::Success
      expect(subject).to be_success
    end

    it "returns proper value" do
      expect(subject.value!).to eq "-124"
    end
  end
end
