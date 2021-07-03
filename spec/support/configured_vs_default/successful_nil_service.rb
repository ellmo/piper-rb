class SuccesfulNilService < PiperService
  pass_nil true

  pipe "return `nil`" do
    nil
  end
end
