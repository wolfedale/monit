module Monit
  class History
    def self.histfile
        db_file = Config.db_file
        create_history_file(db_file) unless File.exist?(db_file)
    end

    def self.create_history_file(db_file)
      db = SQLite3::Database.new db_file
      result = db.execute <<-SQL
      CREATE TABLE hosts (
        id INTEGER PRIMARY KEY,
        datetime VARCHAR(30),
        hostname VARCHAR(30),
        status VARCHAR(8)
      );
      SQL
    end

    def self.db
      db = SQLite3::Database.new Config.db_file
      return db
    end

    def self.show
      db.execute 'SELECT * FROM hosts' do |row|
        p row
      end
    end

    def self.save(host, status)
      histfile
      if select(host).empty?
        db.execute "INSERT INTO hosts(datetime, hostname, status) VALUES ('#{Time.now.to_s}', '#{host}', '#{status}')"
      else
        db.execute "UPDATE hosts set datetime='#{Time.now.to_s}', hostname='#{host}', status='#{status}' where hostname='#{host}'" 
      end
    end

    def self.select(host)
      histfile
       result = db.execute "SELECT * from hosts where hostname='#{host}'";
       return result
    end

  end
end
