module FormObject
  class BooleanType
    class << self
      def process(params, name)
        value = params[name]
        value = params[name.to_s] if value.nil?

        return nil if value.nil?

        return value if [TrueClass, FalseClass].include?(value.class)

        value.present? && ["true", "yes", "1"].include?(value)
      end
    end
  end

  self.field_types[:boolean] = BooleanType
end
