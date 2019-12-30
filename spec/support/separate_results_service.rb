class SeparateResultsService < DryService
  attribute :input, Types::Coercible::Float

  pipe :inline_spearate_results do
    doubled_input = 2 * input

    message { "doubled input is not greater than 100" }
    cond    { doubled_input > 100 }
    object  { cond ? doubled_input : input }
  end
end
