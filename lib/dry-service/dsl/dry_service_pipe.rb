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
      @result       = instance_eval(&@block)

      result_object = @__result_object || result
      condition     = @__condition || result

      if condition.is_a? Dry::Monads::Result
        condition
      elsif condition
        Success(result_object || true)
      else
        failure_object = { service: service, object: result_object, message: @__error_message }
        failure_object[:step] = step_name if service.class.debug_steps?

        Failure(failure_object)
      end
    end

  protected

    def message(str)
      @__error_message = str
    end

    def object(obj)
      @__result_object = obj
    end

    def cond(&block)
      @__condition = instance_eval(&block)
    end

    def bump(atr_name, val)
      attr[atr_name] = val
      true
    end

    def method_missing(meth, *args, &block)
      return attr[meth] if attr.key? meth

      super
    end

    def respond_to_missing?(meth, *args, &block)
      attr.key?(meth) || super
    end
  end
end
