class ParentService < PiperService
  pass_nil       true
  pass_exception true

  pipe "return `nil`" do
    nil
  end

  pipe "raise exception" do
    raise StandardError, "Who's your daddy?"
  end
end
