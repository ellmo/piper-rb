module PiperDSL
  module PiperConfig
    DEFAULT__PASS_NIL       = false
    DEFAULT__PASS_EXCEPTION = false

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def pass_nil(val)
        @__pass_nil = val
      end

      def pass_nil?
        @__pass_nil ||= if defined?(@__pass_nil)
                          @__pass_nil
                        elsif superclass < PiperService
                          superclass.pass_nil?
                        else
                          DEFAULT__PASS_NIL
                        end
      end

      def pass_exception(val)
        @__pass_exception = val
      end

      def pass_exception?
        @__pass_exception ||= if defined?(@__pass_exception)
                                @__pass_exception
                              elsif superclass < PiperService
                                superclass.pass_exception?
                              else
                                DEFAULT__PASS_EXCEPTION
                              end
      end

      def skip_transaction!
        @__skip_transaction = true
      end

      def skip_transaction?
        !@__skip_transaction.nil?
      end

      def debug_steps
        @__debug_steps = true
      end

      def debug_steps?
        !@__debug_steps.nil?
      end
    end

    def pass_nil?
      self.class.pass_nil?
    end

    def pass_exception?
      self.class.pass_exception?
    end

    def skip_transaction?
      self.class.skip_transaction?
    end

    def debug_steps?
      self.class.debug_steps?
    end
  end
end
