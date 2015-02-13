module FormObject
  class DateTimeType
    class << self
      def process(params, name)
        year   = params["#{name}(1i)"]
        month  = params["#{name}(2i)"]
        day    = params["#{name}(3i)"]
        hour   = params["#{name}(4i)"]
        minute = params["#{name}(5i)"]
        second = params["#{name}(6i)"]

        if year && month && day && hour && minute && second
          DateTime.new(year, month, day, hour, minute, second)
        end
      end
    end
  end

  self.field_types[:datetime] = DateTimeType
end
