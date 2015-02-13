module FormObject
  class TimeType
    class << self
      def process(params, name)
        value = params[name] || params[name.to_s]

        return value if value && value.class == Time
      
        return value.to_time if value && value.respond_to?(:to_time)

        year   = params["#{name}(1i)"]
        month  = params["#{name}(2i)"]
        day    = params["#{name}(3i)"]
        hour   = params["#{name}(4i)"]
        minute = params["#{name}(5i)"]
        second = params["#{name}(6i)"]

        if [year, month, day, hour, minute, second].any?(&:present?)
          Time.new(year.to_i, month.to_i, day.to_i, hour.to_i, minute.to_i, second.to_i) rescue nil
        end
      end
    end
  end

  self.field_types[:time] = TimeType
end
