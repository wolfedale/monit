module Monit
  class Timer
   
    def self.is_critical_was_ok(host, result)
      Log.new.host(Time.now, host, result)
      History.save(host, result, Time.now.to_i)
      notification(host, result)
    end

    def self.is_critical_was_critical(host, result)
      notification(host, result) if time_range(host) > Config.time_range.to_i
      History.save(host, result, Time.now.to_i) if time_range(host) > Config.time_range.to_i
      Log.new.host(Time.now, host, result)
    end

    def self.is_ok_was_ok(host, result)
      Log.new.host(Time.now, host, result)
      History.save(host, result)
    end

    def self.is_ok_was_critical(host, result)
      Log.new.host(Time.now, host, result)
      History.save(host, result)
      notification(host, result)
    end

    def self.time_range(host)
      Time.now.to_i - History.epochtime(host).to_i
    end

    def self.notification(host, result)
      overview_text = "Monit: #{host} is #{result}"
      Email.send_email(overview_text, overview_text, Config.recipient)
    end

  end
end
