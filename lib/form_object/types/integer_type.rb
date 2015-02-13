require 'active_support/core_ext/string'

module FormObject
  class IntegerType
    class << self
      def process(params, name)
        value = params[name] || params[name.to_s]
        value.to_i if value.present?
      end
    end
  end

  self.field_types[:integer] = IntegerType
end