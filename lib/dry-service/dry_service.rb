require "dry-monads"
require "dry-struct"
require "dry-types"

require_relative "./dsl/dry_service_steps"
require_relative "./dsl/dry_service_pipe"

class DryService < Dry::Struct
  include DryServiceDSL::DryServiceSteps

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

  def pipe(desc = nil, &block)
    raise ArgumentError, "missing block" unless block_given?

    DryServiceDSL::Pipe.new(self, attributes, desc, &block).call
  end
end
