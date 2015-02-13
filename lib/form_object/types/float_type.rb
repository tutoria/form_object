require 'active_support/core_ext/string'

module FormObject
  class FloatType
    class << self
      def process(params, name)
        value = params[name] || params[name.to_s]
        value.to_f if value.present?
      end
    end
  end

  self.field_types[:float] = FloatType
end