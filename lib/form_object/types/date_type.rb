module FormObject
  class DateType
    class << self
      def process(params, name)
        value = params[name] || params[name.to_s]

        return value if value && value.kind_of?(Date)

        year   = params["#{name}(1i)"]
        month  = params["#{name}(2i)"]
        day    = params["#{name}(3i)"]

        if year && month && day
          Date.new(year, month, day)
        end
      end
    end
  end

  self.field_types[:date] = DateType
end
