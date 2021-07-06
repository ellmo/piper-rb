class TransactionService < PiperService
  pipe "fail the pipe" do
    false
  end
end

class SkipTransactionService < PiperService
  skip_transaction!

  pipe "fail the pipe" do
    false
  end
end
