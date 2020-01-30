module PiperDSL
  module PiperHelpers
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
    alias mssg message

    def result_object
      return @__result_object unless block_given?

      @__result_object = yield
    end
    alias object result_object
    alias rslt result_object

    def fail_object
      return @__fail_object unless block_given?

      @__fail_object = yield
    end
    alias fobj fail_object

    def condition
      return @__condition unless block_given?

      @__condition = yield
    end
    alias cond condition

    def condition_manual?
      !defined?(@__condition).nil?
    end

    def last_result=(val)
      @__last_result = val
    end

    def last_result
      @__last_result
    end
  end
end
