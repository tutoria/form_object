module FormObject
  class DateTimeType
    class << self
      def process(params, name)
        value = params[name] || params[name.to_s]

        return value if value && value.class == DateTime

        return value.to_datetime if value && value.respond_to?(:to_datetime)

        year   = params["#{name}(1i)"]
        month  = params["#{name}(2i)"]
        day    = params["#{name}(3i)"]
        hour   = params["#{name}(4i)"]
        minute = params["#{name}(5i)"]
        second = params["#{name}(6i)"]

        if [year, month, day, hour, minute, second].any?(&:present?)
          time_zone_offset = Time.zone.formatted_offset rescue '+00:00'
          DateTime.new(year.to_i, month.to_i, day.to_i, hour.to_i, minute.to_i, second.to_i).change(offset: time_zone_offset) rescue nil
        end
      end
    end
  end

  self.field_types[:datetime] = DateTimeType
end
