require_relative "parent_service"

class ProdigalSonService < ParentService
  pass_nil false

  pipe "return `nil`" do
    nil
  end
end
