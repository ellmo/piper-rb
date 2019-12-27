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
        result = perform_steps

        raise ActiveRecord::Rollback if result.failure?
      end
    else
      result = perform_steps
    end

    result
  end

  def self.pipe(desc, &block)
    raise ArgumentError, "missing block" unless block_given?

    pipepart = DryServiceDSL::Pipe.new(desc, &block)

    service_steps << pipepart
  end
end
