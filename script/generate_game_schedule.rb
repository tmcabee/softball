require 'rubygems'

file = File.join File.dirname(__FILE__), 'schedules', 'ver_3a.csv'
ScheduleParser.new(file).parse
