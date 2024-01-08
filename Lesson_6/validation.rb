# В файле validation.rb
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, validation_type, *args)
      @validations ||= []
      @validations << { name: name, type: validation_type, args: args }
    end
  end

  module InstanceMethods
    def validate!
      self.class.instance_variable_get(:@validations).each do |validation|
        send("validate_#{validation[:type]}", validation[:name], *validation[:args])
      end
    end

    private

    def validate_presence(name)
      value = instance_variable_get("@#{name}")
      raise "Значение не может быть нулевым или пустым" if value.nil? || value.empty?
    end

    def validate_format(name, format)
      value = instance_variable_get("@#{name}")
      raise "Не верный формат" unless value.to_s.match?(Regexp.new(format))
    end

    def validate_type(name, type)
      value = instance_variable_get("@#{name}")
      raise "Не верный тип" unless value.is_a?(type)
    end
  end
end
