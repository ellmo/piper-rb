class ParentService < PiperService
  pass_nil         true
  handle_exception true

  pipe "return `nil`" do
    nil
  end

  pipe "raise exception" do
    raise StandardError, "Who's your daddy?"
  end
end
