module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instance_counter

    @@instance_counter = 0

    def instances
      @@instance_counter
    end
  end

  protected

  module InstanceMethods
    def register_instance
      self.class.instance_counter += 1
    end
  end
end



