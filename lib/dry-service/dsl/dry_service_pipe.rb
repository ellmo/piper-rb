module DryServiceDSL
  class Pipe
    include Dry::Monads[:result]

    attr_reader :service, :attr
    attr_reader :desc, :result
    alias description desc
    alias attributes  attr

    def initialize(desc, &block)
      @desc       = desc
      @block      = block
    end

    def perform(service, step_name)
      @service      = service
      @attr         = service.attributes
      @result       = service.instance_eval(&@block)

      result_object = service.object  || result
      condition     = service.cond    || result

      if condition.is_a? Dry::Monads::Result
        condition
      elsif condition
        Success(result_object || true)
      else
        failure_object = { service: service, object: result_object, message: service.message }
        failure_object[:step] = step_name if service.class.debug_steps?

        Failure(failure_object)
      end
    end
  end
end
