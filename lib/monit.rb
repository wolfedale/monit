module Monit
  require 'json'
  require 'yaml'
  require 'time'
  require 'monit/version'
  require 'monit/notifier'
  require 'monit/config'
  require 'net/ping'
  require 'monit/check'
  require 'monit/log'
  
  def self.hi
    puts "Hello world!"
  end

  def self.check(host)
    puts host
  end
end
