class SyntaxCheckerService < DryService
  attribute :input, Types::Strict::Integer

protected

  pipe :asd do
    pass(:input, input + 1)
  end

  pipe :qwe do
    pass(:input, input * -1)
  end

  pipe(:zxc) { input.to_s }
end
