module Monit
  class Check
    def self.ping(host)
      p1 = Net::Ping::ICMP.new(host)
      p1.ping?
    end
    
    def self.host(host)
      # Checking if there is a lock.
      Monit::Locker.checkit

      # Checking the current status of host
      result = ping(host) ? "OK" : "CRITICAL"
  
      # Save the current status to the database
      History.save(host, result) if History.hostexist?(host) == false

      # Execute methods according to the statuses.
      Timer.is_critical_was_critical(host, result) if result == "CRITICAL" and History.status(host) == "CRITICAL"
      Timer.is_ok_was_ok(host, result) if result == "OK" and History.status(host) == "OK"
      Timer.is_ok_was_critical(host, result) if result == "OK" and History.status(host) == "CRITICAL"
      Timer.is_critical_was_ok(host, result) if result == "CRITICAL" and History.status(host) == "OK"

      # Delete lock
      Monit::Locker.deletef
    end
  end
end
