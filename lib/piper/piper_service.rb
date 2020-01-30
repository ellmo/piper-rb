require "dry-monads"
require "dry-struct"
require "dry-types"

require_relative "./dsl/piper_helpers"
require_relative "./dsl/piper_pipe"
require_relative "./dsl/piper_steps"

class PiperService < Dry::Struct
  include PiperDSL::PiperSteps
  include PiperDSL::PiperHelpers
  include Dry::Monads[:result]

  module Types
    include Dry.Types()
  end

  def initialize(_)
    raise NotImplementedError unless self.class < PiperService

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

    pipepart = PiperDSL::Pipe.new(desc, &block)

    service_steps << pipepart
  end
end
