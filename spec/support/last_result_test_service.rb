class LastResultTestService < PiperService
  attribute :input, Types::Any

  pipe "this step`s result should be passed to..." do
    input * 30
  end

  pipe "...to this step" do
    cond    { last_result == input * 30 }
    object  { last_result }
  end
end
