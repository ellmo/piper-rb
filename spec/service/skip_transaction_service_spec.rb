context "configured vs default options" do
  subject       { described_class.new.call }

  before do
    class_double("ActiveRecord::Base")
      .as_stubbed_const(transaction: true)
  end

  describe SkipTransactionService do
    it "doesn't touch ActiveRecord" do
      expect(ActiveRecord::Base).not_to receive(:transaction) # rubocop:disable RSpec/MessageSpies

      subject
    end
  end

  describe TransactionService do
    before do
      allow(ActiveRecord::Base)
        .to receive(:transaction)
        .and_return(true)
    end

    it "doesn't touch ActiveRecord" do
      subject
      expect(ActiveRecord::Base).to have_received(:transaction)
    end
  end
end
