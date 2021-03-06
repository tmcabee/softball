require 'rubygems'

abort("Usage: rails runner script/generate_game_schedule.rb <schedule_file>") if ARGV.empty?

file = File.join File.dirname(__FILE__), "schedules", "#{ARGV[0]}.csv"
schedule = ScheduleParser.new(file).parse
schedule.find_missing_games_and_cancel!

File.open("baseline.out", "w") do |f|
  f.puts schedule.to_csv
end

