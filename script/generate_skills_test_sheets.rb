require 'rubygems'

abort("Usage: rails runner script/generate_skills_test_sheets.rb <complete_registration_file> [make_up]") if ARGV.empty?

file = File.join File.dirname(__FILE__), "registrations", "#{ARGV[0]}.csv"
registration_list = RegistrationParser.new(file, ARGV[1]).parse

puts "Generating master sheet..."
File.open("skills/master_list.csv", "w") do |f|
  f.puts registration_list.master_list
end

Division.all.each do |division|
  next if division.no_skills_test?
  puts "Generating sheets for #{division.abbreviation}"
  File.open("skills/#{division.abbreviation}_league_director.csv", "w") do |f|
    f.puts registration_list.league_director_list_for division
  end
  File.open("skills/#{division.abbreviation}_coaches.csv", "w") do |f|
    f.puts registration_list.coaches_list_for division
  end
end
