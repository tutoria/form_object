require 'active_support/concern'
require 'active_support/deprecation'
require 'active_support/core_ext/class'
require 'active_support/hash_with_indifferent_access'

require_relative 'types/boolean_type'
require_relative 'types/integer_type'
require_relative 'types/float_type'
require_relative 'types/datetime_type'
require_relative 'types/date_type'
require_relative 'types/time_type'
require_relative 'types/string_type'

module FormObject
  module Mixin
    extend ActiveSupport::Concern

    module ClassMethods
      def field(name, type, options={})
        self.form_object_fields ||= []
        self.form_object_fields << [name, type]

        attr_reader(:field_attributes) unless method_defined?(:field_attributes)

        case options[:attr]
        when :writer then
          field_writer name
        when :reader then
          field_reader name
        when :accessor, nil then
          field_accessor name
        end
      end

      def field_writer(name)
        define_method("#{name}=") do |value|
          @field_attributes[name] = value
        end
      end

      def field_reader(name)
        define_method(name) do
          @field_attributes[name]
        end
      end

      def field_accessor(name)
        field_writer(name)
        field_reader(name)
      end     
    end

    included do
      class_attribute :form_object_fields
    end

    def assign_fields(params)
      @field_attributes ||= HashWithIndifferentAccess.new

      self.class.form_object_fields.each do |(name, type)|
        if !(value = FormObject.field_types[type].process(params, name)).nil?
          @field_attributes[name] = value
        end
      end
    end
  end
end
