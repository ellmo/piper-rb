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

  def pipe(description = nil)
    raise ArgumentError, "missing block" unless block_given?

    result        = yield
    passed_object = @__result_object || result

    if result
      Success(passed_object || true)
    else
      Failure(service: self, obj: passed_object, message: @__error_message)
    end
  end

  def message(str)
    @__error_message = str
  end

  def object(obj)
    @__result_object = obj
  end
end
