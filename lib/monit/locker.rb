module Monit
  class Locker

    def self.templock
      templock = "/tmp/monit_lock"
    end

    def self.locker
      true if File.exists?(templock)
    end

    def self.createf
      File.open(templock, File::RDWR|File::CREAT, 0644) do |f|
        f.flock(File::LOCK_EX)
      end
    end

    def self.deletef
      File.delete(templock)
    end

    def self.checkit
      if locker == true
        exit
      else
        createf
      end
    end

    private_class_method :locker, :templock, :createf
  end
end
