module DryServiceDSL
  class Pipe
    include ::Dry::Monads[:result]

    attr_reader :service

    def initialize(step_name, &block)
      @step_name  = step_name
      @block      = block
    end

    def perform(service, last_result = nil)
      @service            = service
      service.last_result = last_result
      result              = service.instance_eval(&@block)
      condition           = service.condition_manual? ? service.cond : result

      @result_object      = service.object      || result
      @fail_object        = service.fail_object || service.object || result

      return condition if condition.is_a? Dry::Monads::Result

      prepare_response!(condition)
    end

  protected

    def prepare_response!(condition)
      if condition
        Success(@result_object || true)
      else
        failure_object = { service: service, object: @fail_object, message: service.message }
        failure_object[:step] = @step_name if service.class.debug_steps?

        Failure(failure_object)
      end
    end
  end
end
