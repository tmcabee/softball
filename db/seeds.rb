# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[1,2,3,4,5,6,7,8,9].each do |field_number|
  Field.find_or_create_by_number_and_description field_number, "Lost Mt. Field ##{field_number}"
end

Division.create! :abbreviation => 'SS',   :key => 'Sugar & Spice',        :number_of_teams => 6
Division.create! :abbreviation => 'SRS',  :key => 'Sr. Sugar & Spice',    :number_of_teams => 3
Division.create! :abbreviation => '8U',   :key => '8U Universal',         :number_of_teams => 11
Division.create! :abbreviation => '10UF', :key => '10U Fast-Pitch',       :number_of_teams => 10
Division.create! :abbreviation => '12UF', :key => '12U Fast-Pitch',       :number_of_teams => 7
Division.create! :abbreviation => '14UF', :key => '14U Fast-Pitch',       :number_of_teams => 4
Division.create! :abbreviation => '15F',  :key => '15+ Fast-Pitch',       :number_of_teams => 4
# Division.create! :abbreviation => '10US', :key => '10U Slow-Pitch',       :number_of_teams => 4
Division.create! :abbreviation => '13US', :key => '13U Slow-Pitch',       :number_of_teams => 3
# Division.create! :abbreviation => '14US', :key => '14U Slow-Pitch',       :number_of_teams => 4
Division.create! :abbreviation => '19US', :key => '19U Slow-Pitch',       :number_of_teams => 3

Division.all.each do |division|
  division.number_of_teams.times do |index|
    Team.find_or_create_by_abbreviation "#{division.abbreviation}#{index+1}"
  end
end
