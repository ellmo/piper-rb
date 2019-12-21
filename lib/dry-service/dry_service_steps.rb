module DryServiceSteps

  module ClassMethods
    def service_steps(*stepnames)
      @service_steps = stepnames.flatten
    end

    def defined_service_steps
      @service_steps || []
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

protected

  def bind_all_steps
    # raise(NotImplementedError, "\#{method} not implemented in the base class; subclasses must implement this method!")

    klass = self.class
    return nil if klass.defined_service_steps.empty?

    arr = klass.defined_service_steps.dup

    result = self.class.instance_method(arr.shift).bind(self).call
    result = result.bind(method(arr.shift)) until arr.empty?
    result
  end
end
