module PiperDSL
  module PiperSteps

    module ClassMethods
      def service_steps
        @service_steps || @service_steps = []
      end

      def debug_steps
        @__debug_steps = true
      end

      def debug_steps?
        !@__debug_steps.nil?
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def debug_steps?
      self.class.debug_steps?
    end

  protected

    def perform_steps
      klass = self.class

      return Success(true) if klass.service_steps.empty?

      arr     = klass.service_steps.dup
      step    = arr.shift

      result  = step.perform(self)
      result  = result.bind(proc_step(arr.shift)) until arr.empty?
      result
    end

    def proc_step(step)
      ->(result) { step.perform(self, result) }
    end
  end
end
