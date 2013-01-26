require 'rubygems'

abort("Usage: rails runner script/generate_master_registration_sheet.rb <complete_registration_file>") if ARGV.empty?

file = File.join File.dirname(__FILE__), "registrations", "#{ARGV[0]}.csv"
registration_list = RegistrationParser.new(file).parse

File.open("output/master_list.csv", "w") do |f|
  f.puts registration_list.master_list
end

RegistrationList::Divisions.constants.each do |const|
  next if const == :SS || const == :SP19U
  division = RegistrationList::Divisions.const_get(const)
  File.open("output/#{division[:abbreviation]}_league_director.csv", "w") do |f|
    f.puts registration_list.league_director_list_for division
  end
  File.open("output/#{division[:abbreviation]}_coaches.csv", "w") do |f|
    f.puts registration_list.coaches_list_for division
  end
end
