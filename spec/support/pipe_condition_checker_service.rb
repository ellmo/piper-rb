class PipeConditionCheckerService < DryService
  debug_steps

  attribute :x, Types::Any
  attribute :y, Types::Any

  FAIL__X_MORE_THAN_Y = "x must be less than y".freeze
  FAIL__NOT_THOUSAND  = "x * y is less than 1000".freeze

  pipe :x_and_y_numeric? do
    x.is_a?(Numeric) && y.is_a?(Numeric)
  end

  pipe :x_less_than_y? do
    message { FAIL__X_MORE_THAN_Y }
    x < y
  end

  pipe :x_times_y_is_enough? do
    result = x * y

    message { FAIL__NOT_THOUSAND }
    object  { result }
    cond    { result >= 1000 }
  end
end
