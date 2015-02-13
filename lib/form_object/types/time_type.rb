module FormObject
  class TimeType
    class << self
      def process(params, name)
        hour   = params["#{name}(4i)"]
        minute = params["#{name}(5i)"]
        second = params["#{name}(6i)"]

        if hour && minute && second
          Time.new(hour, minute, second)
        end
      end
    end
  end

  self.field_types[:time] = TimeType
end
