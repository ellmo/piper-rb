class InlineOptionsService < PiperService
  pass_nil         false
  handle_exception false

  pipe "return `nil`", pass_nil: true do
    nil
  end

  pipe "raise exception", handle_exception: true do
    raise StandardError, "We are handled inline."
  end
end

class InlineOverrideOneService < PiperService
  pass_nil true

  pipe "return `nil`", pass_nil: false do
    nil
  end
end

class InlineOverrideTwoService < PiperService
  pass_nil         false
  handle_exception true

  pipe "return `nil`", pass_nil: true do
    nil
  end

  pipe "raise exception", handle_exception: false do
    raise StandardError, "Handling was rescinded."
  end
end
