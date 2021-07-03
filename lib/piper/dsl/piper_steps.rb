module PiperDSL
  module PiperSteps
    module ClassMethods
      def service_steps
        @service_steps || @service_steps = []
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

  protected

    def perform_steps
      klass = self.class

      return Success(true) if klass.service_steps.empty?

      steps_array = klass.service_steps.dup
      step        = steps_array.shift

      result  = step.perform(self)
      result  = result.bind(proc_step(steps_array.shift)) until steps_array.empty?
      result
    end

    def proc_step(step)
      ->(result) { step.perform(self, result) }
    end
  end
end
