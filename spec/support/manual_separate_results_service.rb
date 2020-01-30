class ManualSeparateResultsService < PiperService
  attribute :input, Types::Coercible::String

  pipe :manual_spearate_results do
    capital_letters = input.scan(/[A-Z]/)

    mssg     { "input has capital letters" }
    cond        { capital_letters.empty? }
    fail_object { capital_letters.join(", ") }
    object      { input }
  end
end
