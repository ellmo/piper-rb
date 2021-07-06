module PiperDSL
  class Pipe
    include ::Dry::Monads[:result]

    attr_reader :service

    def initialize(step_name, **options, &block)
      @step_name        = step_name
      @block            = block
      @pass_nil         = options[:pass_nil]
      @handle_exception = options[:handle_exception]
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
    rescue StandardError => e
      pass_exception!(e)
    end

  protected

    def prepare_response!(condition)
      if condition
        Success(@result_object || true)
      elsif condition.nil? && pass_nil?
        Success(nil)
      else
        failure_object = { service: service, object: @fail_object, message: service.message }
        failure_object[:step] = @step_name if service.class.debug_steps?

        Failure(failure_object)
      end
    end

    def pass_exception!(exception)
      raise exception unless handle_exception?

      Failure(service: service, object: exception, message: exception.message)
    end

    def pass_nil?
      @pass_nil.nil? ? service.pass_nil? : @pass_nil
    end

    def handle_exception?
      @handle_exception.nil? ? service.handle_exception? : @handle_exception
    end
  end
end
