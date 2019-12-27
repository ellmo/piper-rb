module DryServiceDSL
  class Pipe
    include Dry::Monads[:result]

    attr_reader :service, :attr, :desc, :result
    alias description desc
    alias attributes  attr

    def initialize(service, attr, desc, &block)
      @service  = service
      @desc     = desc
      @attr     = attr
      @result   = instance_eval(&block)
    end

    def call
      result_object = @__result_object || result

      if result
        Success(result_object || true)
      else
        Failure(service: service, object: result_object, message: @__error_message)
      end
    end

  protected

    def message(str)
      @__error_message = str
    end

    def object(obj)
      @__result_object = obj
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
