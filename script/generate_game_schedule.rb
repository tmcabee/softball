require 'rubygems'

file = File.join File.dirname(__FILE__), 'schedules', 'schedule_ver_3a.csv'
ScheduleParser.new(file).parse
