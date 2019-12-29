module DryServiceDSL
  module DryServiceHelpers
    FAIL__NO_BLOCK = "Expected a block. None given.".freeze

    def bump(attribute)
      raise ArgumentError, FAIL__NO_BLOCK unless block_given?

      attributes[attribute] = yield
    end

    def message
      return @__error_message unless block_given?

      @__error_message = yield
    end
    alias fail_message message

    def object
      return @__result_object unless block_given?

      @__result_object = yield
    end
    alias result_object object

    def cond
      return @__condition unless block_given?

      @__condition = yield
    end
    alias condition cond

    def last_result=(val)
      @__last_result = val
    end

    def last_result
      @__last_result
    end
  end
end
