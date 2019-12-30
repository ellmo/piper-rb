describe ManualSeparateResultsService do
  subject { service.call }

  let(:service) { described_class.new(params) }

  context "passing a string with no capital letters" do
    let(:params) { { input: "ParaMeteR" } }

    it "results in failure" do
      expect(subject).to be_failure
    end

    it "returns prepared fail object" do
      expect(subject.failure[:object]).to eq "P, M, R"
    end
  end

  context "passing a number greater than than 51" do
    let(:params) { { input: "parameter" } }

    it "results in success" do
      expect(subject).to be_success
    end

    it "returns input" do
      expect(subject.value!).to eq "parameter"
    end
  end
end
