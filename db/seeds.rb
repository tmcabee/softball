# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
sugar_and_spice = {
  'SS1' => 'SS1 Matthews',
  'SS2' => 'SS2 Isley',
  'SS3' => 'SS3 Paul',
  'SS4' => 'SS4 Roberson',
  'SS5' => 'SS5 Goodwin',
  'SS6' => 'SS6 Zirpoly',
}

senior_sugar_and_spice = {
  'SRS1' => 'SRSS1 Pendergrass',
  'SRS2' => 'SRSS2 Thomas',
  'SRS3' => 'SRSS3 Lovett',
  'SRS4' => 'SRSS4 Mitchell',
  'SRS5' => 'SRSS5 Clontz',
  'SRS6' => 'SRSS6  Redden',
}

universal_8u = {
  '8U1' => '8U1 Brantley',
  '8U2' => '8U2 Mueller',
  '8U3' => '8U3 Hambrick',
  '8U4' => '8U4 Turpin',
  '8U5' => '8U5 Edwards',
  '8U6' => '8U6 Stroud',
  '8U7' => '8U7 Chauvin',
  '8U8' => '8U8 Hearing',
  '8U9' => '8U9 Bartley',
  '8U10' => '8U10 Chapman',
  '8U11' => '8U11 Hardy',
  '8U12' => '8U12 Sandy',
  '8U13' => '8U13 Murphy',
  '8U14' => '8U14McAbee',
}

leagues = [sugar_and_spice, senior_sugar_and_spice, universal_8u]

leagues.each do |teams|
  teams.each do |abbreviation, name|
    Team.find_or_create_by_abbreviation_and_name abbreviation, name
  end
end
