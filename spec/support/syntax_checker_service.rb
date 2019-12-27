class SyntaxCheckerService < DryService
  attribute :input, Types::Strict::Integer

  service_steps :asd, :qwe, :zxc

protected

  def asd
    pipe do
      input + 1
    end
  end

  def qwe(input)
    pipe { input * -1 }
  end

  def zxc(input)
    pipe { input.to_s }
  end
end
