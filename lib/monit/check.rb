module Monit
  class Check
    def self.ping(host)
      p1 = Net::Ping::ICMP.new(host)
      p1.ping?
    end
    
    def self.host(host)
     result = ping(host) ? "OK" : "CRITICAL"
     puts "#{host} - now: #{result} | from_db: #{History.status(host)}"
     History.save(host, result)
    end
  end
end
