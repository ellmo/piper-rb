module DryServiceDSL
  module DryServiceHelpers

    EXC__NO_BLOCK = "Expected a block. None given.".freeze

    def bump(attribute)
      raise ArgumentError, EXC__NO_BLOCK unless block_given?

      attributes[attribute] = yield
    end

    def message
      return @__error_message unless block_given?

      @__error_message = yield
    end

    def object
      return @__result_object unless block_given?

      @__result_object = yield
    end

    def cond
      return @__condition unless block_given?

      @__condition = yield
    end
  end
end
