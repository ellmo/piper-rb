describe NestingService do
  subject { service.call }

  let(:service) { described_class.new(params) }

  context "passing a number lesser than 15" do
    let(:params) { { input: 10 } }
    let(:failure_object) { subject.failure }

    it "results in failure" do
      expect(subject).to be_failure
    end

    it "passes message from NestedService" do
      expect(failure_object[:message]).to eq NestedService::FAIL__I_AM_THE_ONE_WHO_KNOCKS }
    end

    it "properly reports NestedService as the one returning result"  do
      expect(failure_object[:service]).to be_a NestedService
    end

    it "yields `false` result object from NestedService"
      expect(failure_object[:object]).to eq false
    end
  end

  context "passing 15" do
    let(:params) { { input: 15 } }
    let(:success_object) { subject.value! }

    it "results in failure" do
      expect(subject).to be_success
    end

    it "value returns `true`" do
      expect(success_object).to eq true
    end
  end
end
