#!/usr/bin/env ruby

unless File.respond_to? :realpath
  class File #:nodoc:
    def self.realpath path
      return realpath(File.readlink(path)) if symlink?(path)
      path
    end
  end
end
$: << File.expand_path(File.dirname(File.realpath(__FILE__)) + '/../lib')

require 'monit'
require 'rubygems'

# Check one by one
Monit.check("wp.pl")
Monit.check("onet.pl")

# Check the list
nodes = "/home/i/monit/hosts.txt"
File.readlines(nodes).each do |host|
  Monit.check(host)
end

# Check the list from json file
require 'json'
file = open("/home/i/json/file.json")
json = file.read
parsed = JSON.parse(json)
parsed.each do |port|
  if port["checkports"] == "Off"
    Monit.check(port["name"])
  end
end
