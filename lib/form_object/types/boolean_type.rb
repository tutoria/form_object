module FormObject
  class BooleanType
    class << self
      def process(params, name)
        value = params[name] || params[name.to_s]
        value.present? && ["true", "yes", "1"].include?(value)
      end
    end
  end

  self.field_types[:boolean] = BooleanType
end
