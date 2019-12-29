class NestingService < DryService
  debug_steps

  attribute :input, Types::Any

  pipe :nothing_to_see_here do
    true
  end

  pipe :calling_nested_service do
    NestedService.new(nested_input: input * 20).call
  end
end

class NestedService < DryService

  attribute :nested_input, Types::Any

  FAIL__I_AM_THE_ONE_WHO_KNOCKS = "I am the one who knocks!".freeze

  pipe :simple_step do
    message FAIL__I_AM_THE_ONE_WHO_KNOCKS
    nested_input >= 300
  end

end
