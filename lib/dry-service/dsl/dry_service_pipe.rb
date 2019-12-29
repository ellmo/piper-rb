module DryServiceDSL
  class Pipe
    include ::Dry::Monads[:result]

    attr_reader :service

    def initialize(description, &block)
      @description  = description
      @block        = block
    end

    def perform(service, last_result = nil)
      service.last_result = last_result

      result        = service.instance_eval(&@block)
      result_object = service.object  || result
      condition     = service.cond    || result

      if condition.is_a? Dry::Monads::Result
        condition
      elsif condition
        Success(result_object || true)
      else
        failure_object = { service: service, object: result_object, message: service.message }
        failure_object[:step] = @description if service.class.debug_steps?

        Failure(failure_object)
      end
    end
  end
end
