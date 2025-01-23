# frozen_string_literal: true

module Validation
  class ValidationError < StandardError; end

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(name, validation_type, param = nil)
      @validations ||= []
      return if @validations.any? { |val| val[:attribute] == name && val[:type] == validation_type }

      @validations << { attribute: name, type: validation_type, param: param }
    end

    def validations
      @validations || []
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        attribute = validation[:attribute]
        value = attribute.is_a?(Symbol) ? instance_variable_get("@#{attribute}") : attribute

        if validation[:type] == :type
          send("validate_#{validation[:type]}", value, *validation[:param])
        else
          send("validate_#{validation[:type]}", attribute, value, *validation[:param])
        end
      end
      true
    end

    def valid?
      validate!
    rescue ValidationError => e
      puts e.message
      false
    end
  end

  private

  def validate_presence(attribute, value)
    raise ValidationError, "#{attribute} cannot be nil" if value.nil? || value.strip.to_s.empty?
  end

  def validate_format(attribute, value, regexp)
    raise ValidationError, "#{attribute} doesnt match format" unless value.to_s =~ regexp
  end

  def validate_type(obj, type)
    raise ValidationError, "#{obj} is not a #{type}" unless obj.is_a?(type)
  end
end
