describe LastResultTestService do
  subject { service.call }

  let(:service) { described_class.new(params) }
  let(:value) { subject.value! }

  context "integer parameter passed" do
    let(:integer) { 10 }
    let(:params) { { input: integer } }

    it "returns `success`" do
      expect(subject).to be_success
    end

    it "returns value passed from previous step" do
      expect(value).to eq(integer * 30)
    end
  end
end
