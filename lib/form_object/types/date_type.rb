module FormObject
  class DateType
    class << self
      def process(params, name)
        value = params[name] || params[name.to_s]

        return value if value && value.class == Date

        return value.to_date if value && value.respond_to?(:to_date)

        year   = params["#{name}(1i)"]
        month  = params["#{name}(2i)"]
        day    = params["#{name}(3i)"]

        if year && month && day
          Date.new(year.to_i, month.to_i, day.to_i)
        end
      end
    end
  end

  self.field_types[:date] = DateType
end
