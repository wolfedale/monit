module Monit
  class Check
    def self.ping(host)
      p1 = Net::Ping::ICMP.new(host)
      p1.ping?
    end
    
    def self.host(host)
     result = ping(host) ? "OK" : "CRITICAL"

     if result == "OK" and History.status(host) == [["OK"]]
       Timer.is_ok(host)
     elsif result == "OK" and History.status(host) == [["CRITICAL"]]
       Timer.is_ok_was_critical(host)
     elsif result == "CRITICAL" and History.status(host) == [["OK"]]
       Timer.is_critical_was_ok(host)
     elsif result == "CRITICAL" and History.status(host) == [["CRITICAL"]]
       Timer.is_critical_was_critical(host)
     end

     History.save(host, result)

    end
  end
end
