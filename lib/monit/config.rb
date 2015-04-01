module Monit
  class Config
    def initialize
      @hash = Hash.new
      @config = YAML.load(File.open("/home/i/git/monit/lib/monit/config.yml"))
    end

    def conf
      @config.each do |key, val|
        @hash[key] = val
      end
    end

    def logconf
      return @log = conf["log"]
    end

    def hosts
      @hosts = conf["hosts"]
      @hosts.each do |host|
        host
      end
      return @hosts
    end
            
  end
end
