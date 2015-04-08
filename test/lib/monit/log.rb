module Monit
  class Log
    def initialize
      @logconf = ::Monit::Config.logconf
      @logfile = File.open(@logconf, "a")
    end

    @@instance = Log.new

    def self.instance
      @@instance
    end

    def host(time, host, status)
      @logfile.puts("#{time} #{host.chomp} #{status}")
    end
  end
end
