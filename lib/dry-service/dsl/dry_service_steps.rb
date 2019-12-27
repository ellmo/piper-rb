module DryServiceDSL
  module DryServiceSteps

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

      return nil if klass.service_steps.empty?

      arr = klass.service_steps.dup

      result = arr.shift.perform(self)
      result = result.bind(proc_step(arr.shift)) until arr.empty?
      result
    end

    def proc_step(step)
      ->(_result) { step.perform(self) }
    end
  end
end
