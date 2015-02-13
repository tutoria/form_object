require 'active_support/concern'
require 'active_support/deprecation'
require 'active_support/core_ext/class'

require_relative 'types/integer_type'
require_relative 'types/float_type'
require_relative 'types/datetime_type'
require_relative 'types/time_type'

module FormObject
  module Mixin
    extend ActiveSupport::Concern

    module ClassMethods
      def field(name, type, options={})
        self.form_object_fields ||= []
        self.form_object_fields << [name, type]

        case options[:attr]
        when :writer then
          attr_writer name
        when :reader then
          attr_reader name
        when :accessor, nil then
          attr_accessor name
        end
      end
    end

    included do
      class_attribute :form_object_fields
    end

    def assign_fields(params)
      self.class.form_object_fields.each do |(name, type)|
        instance_variable_set("@#{name}", FormObject.field_types[type].process(params, name))
      end
    end
  end
end
