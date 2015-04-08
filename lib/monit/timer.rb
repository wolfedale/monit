module Monit
  class Timer
   
    def self.is_ok
      "is_ok"
    end

    def self.is_critical_was_ok
      "is_critical_was_ok"
    end

    def self.is_critical_was_critical
      "is_critical_was_critical"
    end

    def self.is_ok_was_ok
      "is_ok_was_ok"
    end

    def self.is_ok_was_critical
      "is_ok_was_critical"
    end

    def self.time_range
      timer = Config.time_range
    end
  end
end
