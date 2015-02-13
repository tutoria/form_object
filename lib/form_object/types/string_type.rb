module FormObject
  class StringType
    class << self
      def process(params, name)
        params[name] || params[name.to_s]
      end
    end
  end

  self.field_types[:string] = StringType
end
