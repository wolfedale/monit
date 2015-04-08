module Monit
  class Timer
   
    def self.is_ok(host)
      puts "#{host} - is_ok"
    end

    def self.is_critical_was_ok(host)
      puts "#{host} - is_critical_was_ok"
    end

    def self.is_critical_was_critical(host)
      puts "#{host} - is_critical_was_critical"
    end

    def self.is_ok_was_ok(host)
      puts "#{host} - is_ok_was_ok"
    end

    def self.is_ok_was_critical(host)
      puts "#{host} - is_ok_was_critical"
    end

    def self.time_range
      timer = Time.now - Config.time_range
    end
  end
end
