require_relative "parent_service"

class GoodBoyService < ParentService
  pipe "return `nil`" do
    nil
  end

  pipe "raise exception" do
    raise StandardError, "Who's your daddy?"
  end
end
