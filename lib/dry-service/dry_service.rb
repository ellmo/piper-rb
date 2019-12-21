require "dry-monads"
require "dry-struct"
require "dry-types"

require_relative "./dry_service_steps"

class DryService < Dry::Struct
  include Dry::Monads[:result]
  include Dry::Monads[:try]
  include DryServiceSteps

  def initialize(_)
    raise NotImplementedError unless self.class < DryService

    super
  end

  def call
    if defined? ActiveRecord::Base
      ActiveRecord::Base.transaction do
        result = bind_all_steps

        raise ActiveRecord::Rollback if result.failure?
      end
    else
      bind_all_steps
    end
  end

protected

  def _fail(obj, message)
    { service: self, obj: obj, message: message }
  end

end
