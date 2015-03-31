module Monit
  class Check
    def self.ping(host)
      p1 = Net::Ping::ICMP.new(host)
      p1.ping?
    end
    
    def self.host(host, log=false)
     result = ping(host) ? "OK" : "CRITICAL"
     Log.instance.host(Time.now, host, result) if log == true
     return result
    end
  end
end
