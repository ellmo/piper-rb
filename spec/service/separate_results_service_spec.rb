describe SeparateResultsService do
  subject { service.call }

  let(:service) { described_class.new(params) }

  context "passing a number less than 51" do
    let(:params) { { input: 20 } }

    it "results in failure" do
      expect(subject).to be_failure
    end

    it "returns unchanged input" do
      expect(subject.failure[:object]).to eq 20
    end
  end

  context "passing a number greater than than 51" do
    let(:params) { { input: 60 } }

    it "results in success" do
      expect(subject).to be_success
    end

    it "returns doubled input" do
      expect(subject.value!).to eq 120
    end
  end
end
