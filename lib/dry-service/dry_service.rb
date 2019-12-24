require "dry-monads"
require "dry-struct"
require "dry-types"

require_relative "./dry_service_steps"

class DryService < Dry::Struct
  include Dry::Monads[:result]
  include DryServiceSteps

  module Types
    include Dry.Types()
  end

  def initialize(_)
    raise NotImplementedError unless self.class < DryService

    super
  end

  def call
    result = nil

    if defined? ActiveRecord::Base
      ActiveRecord::Base.transaction do
        result = bind_all_steps

        raise ActiveRecord::Rollback if result.failure?
      end
    else
      result = bind_all_steps
    end

    result
  end

protected

  def _fail(obj, message = nil)
    Failure(service: self, obj: obj, message: message)
  end

  def _pass(obj)
    Success(obj)
  end

end
