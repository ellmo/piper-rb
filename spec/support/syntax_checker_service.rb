class SyntaxCheckerService < DryService
  attribute :input, Types::Strict::Integer

  pipe :asd do
    bump(:input) { input + 1 }
  end

  pipe(:qwe) {
    bump(:input) { input * -1 }
  }

  pipe(:zxc) { input.to_s }
end
