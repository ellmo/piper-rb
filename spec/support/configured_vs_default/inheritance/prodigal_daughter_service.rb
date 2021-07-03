require_relative "parent_service"

class ProdigalDaughterService < ParentService
  pass_exception false

  pipe "return `nil`" do
    nil
  end

  pipe "raise exception" do
    raise StandardError, "Don't call me girl"
  end
end
