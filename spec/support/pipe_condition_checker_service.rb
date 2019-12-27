class PipeConditionCheckerService < DryService
  attribute :x, Types::Any
  attribute :y, Types::Any

  service_steps :x_and_y_numeric?,
                :x_less_than_y?,
                :x_times_y_is_enough?

  FAIL__X_MORE_THAN_Y = "x must be less than y".freeze
  FAIL__NOT_THOUSAND  = "x * y is less than 1000".freeze

protected

  def x_and_y_numeric?
    pipe do
      x.is_a?(Numeric) && y.is_a?(Numeric)
    end
  end

  def x_less_than_y?(_)
    pipe do
      message FAIL__X_MORE_THAN_Y

      x < y
    end
  end

  def x_times_y_is_enough?(_)
    pipe do
      message FAIL__NOT_THOUSAND
      object(result = x*y)

      result >= 1000
    end
  end
end
