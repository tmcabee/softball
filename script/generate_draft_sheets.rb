require 'rubygems'

abort("Usage: rails runner script/generate_draft_sheets.rb <complete_registration_file>") if ARGV.empty?

file = File.join File.dirname(__FILE__), "registrations", "#{ARGV[0]}.csv"
registration_list = RegistrationParser.new(file).parse

Division.all.each do |division|
  File.open("drafts/#{division.abbreviation}_league_director.csv", "w") do |f|
    f.puts registration_list.league_director_draft_for division
  end
  File.open("drafts/#{division.abbreviation}_coaches.csv", "w") do |f|
    f.puts registration_list.coaches_draft_for division
  end
end

