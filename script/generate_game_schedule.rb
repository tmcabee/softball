require 'rubygems'
require 'nokogiri'
require 'open-uri'

schedule = Schedule.create_from Nokogiri::HTML(open(url))
schedule.to_csv