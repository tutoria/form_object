module FormObject
  class TimeType
    class << self
      def process(params, name)
        value = params[name] || params[name.to_s]

        return value if value && value.class == Time

        return value.to_time if value && value.respond_to?(:to_date)

        hour   = params["#{name}(4i)"]
        minute = params["#{name}(5i)"]
        second = params["#{name}(6i)"]

        if hour && minute && second
          Time.new(hour.to_i, minute.to_i, second.to_i)
        end
      end
    end
  end

  self.field_types[:time] = TimeType
end
