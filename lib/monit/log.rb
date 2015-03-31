# logs.txt => Monit::Conf
module Monit
  class Log
    def initialize
      @logfile = File.open("logs.txt", "a")
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
