require 'rubygems'

abort("Usage: rails runner script/generate_concessions_schedule.rb <schedule_file>") if ARGV.empty?

file = File.join File.dirname(__FILE__), "schedules", "#{ARGV[0]}.csv"
schedule = ConcessionsScheduleParser.new(file).parse

File.open("concessions_baseline.out", "w") do |f|
  f.puts schedule.to_csv
end

