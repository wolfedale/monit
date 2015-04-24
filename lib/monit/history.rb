module Monit
  class History
    def self.histfile
        db_file = Config.db_file
        create_history_file(db_file) unless File.exist?(db_file)
    end

    def self.dbupdate
      SQLite3::Database.new( Config.db_file )
    end

    def self.create_history_file(db_file)
      dbupdate
      result = dbupdate.execute <<-SQL
      CREATE TABLE hosts (
        id INTEGER PRIMARY KEY,
        datetime VARCHAR(30),
        epochtime VARCHAR(30),
        hostname VARCHAR(30),
        status VARCHAR(8)
      );
      SQL
    end

    def self.db(host)
      hash = Hash.new
      SQLite3::Database.new( Config.db_file, options = {} ) do |query|
        query.results_as_hash = true
        query.execute( "SELECT * FROM hosts where hostname='#{host}'" ) do |row|
          hash = row
        end
       return hash
      end 
    end

    def self.hostexist?(host)
      histfile
      return db(host).has_key?('status')
    end

    def self.status(host)
      histfile
      return db(host)['status']
    end

    def self.datetime(host)
      histfile
      return db(host)['datetime']
    end

    def self.epochtime(host)
      histfile
      return db(host)['epochtime']
    end

    def self.save(host, status, epoch="null")
      histfile
      if hostexist?(host) == false
        dbupdate.execute "INSERT INTO hosts(datetime, epochtime, hostname, status) VALUES ('#{Time.now.to_s}', '#{epoch}', '#{host}', '#{status}')"
      elsif
        dbupdate.execute "UPDATE hosts set datetime='#{Time.now.to_s}', epochtime='#{epoch}', hostname='#{host}', status='#{status}' where hostname='#{host}'" 
      end
    end

    private_class_method :histfile, :dbupdate, :create_history_file, :db

  end
end
