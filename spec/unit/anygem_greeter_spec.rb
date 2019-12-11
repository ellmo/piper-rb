describe AnyGem::Greeter do
  describe ".hi" do
    let(:expected_text) { "Hello world!\n" }

    it do
      expect do
        described_class.hi
      end.to output(expected_text).to_stdout
    end
  end
end
