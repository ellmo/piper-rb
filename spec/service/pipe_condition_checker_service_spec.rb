describe PipeConditionCheckerService do
  subject { service.call }

  let(:service) { described_class.new(params) }

  context "any of the params is not Numeric" do
    let(:params) { { x: "a", y: 2 }  }
    let(:result) do
      {
        service:  service,
        object:   false,
        message:  nil
      }
    end

    it "results in failure" do
      expect(subject).to be_failure
    end

    it "returns default result object" do
      expect(subject.failure).to eq result
    end
  end

  context "both params are numeric" do
    context "x is more than y" do
      let(:params) { { x: 30, y: 20 }  }
      let(:result) do
        {
          service:  service,
          object:   false,
          message:  described_class::FAIL__X_MORE_THAN_Y
        }
      end

      it "results in failure" do
        expect(subject).to be_failure
      end

      it "returns result object with message" do
        expect(subject.failure).to eq result
      end
    end

    context "x is less than y" do
      context "x times y is NOT 1000 or more" do
        let(:params) { { x: 20, y: 40 }  }
        let(:result) do
          {
            service:  service,
            object:   800,
            message:  described_class::FAIL__NOT_THOUSAND
          }
        end

        it "results in failure" do
          expect(subject).to be_failure
        end

        it "returns result object with message and object" do
          expect(subject.failure).to eq result
        end
      end

      context "x times y is 1000 or more" do
        let(:params) { { x: 30, y: 40 }  }
        let(:result) { 1200 }

        it "results in success" do
          expect(subject).to be_success
        end

        it "returns custom value" do
          expect(subject.value!).to eq result
        end
      end
    end
  end
end
