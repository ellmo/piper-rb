class ConfiguredService < PiperService
  pass_nil       true
  pass_exception true

  pipe "return `nil`" do
    nil
  end

  pipe "raise exception" do
    raise StandardError, "Here's Johnny!"
  end
end
