module Monit
  class Config

    def self.conf
      @config = YAML.load_file("/etc/monit/config.yml")
    end

    def self.logconf
      @log = conf["log"]
    end

    def self.hosts
      @hosts = conf["hosts"]
    end

    def self.recipient
      @recipient = conf["email_recipient"]
    end

    def self.subject
      @subject = conf["email_subject"]
    end

    def self.body
      @body = conf["email_body"]
    end            
 
    def self.db_file
      @db_file = conf["db_file"]
    end

    def self.time_range
      @time_range = conf["time_range"]
    end

  end
end
