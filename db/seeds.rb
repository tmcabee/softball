# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[1,2,3,4,5,6,7,8].each do |field_number|
  Field.find_or_create_by_number_and_description field_number, "Lost Mt. Field ##{field_number}"
end

sugar_and_spice = {
  'SS1' => '',
  'SS2' => '',
  'SS3' => '',
  'SS4' => '',
  'SS5' => '',
  'SS6' => '',
}

senior_sugar_and_spice = {
  'SRS1' => '',
  'SRS2' => '',
  'SRS3' => '',
  'SRS4' => '',
}

universal_8u = {
  '8U1' => '',
  '8U2' => '',
  '8U3' => '',
  '8U4' => '',
  '8U5' => '',
  '8U6' => '',
  '8U7' => '',
  '8U8' => '',
  '8U9' => '',
  # '8U10' => '',
  # '8U11' => '',
  # '8U12' => '',
  # '8U13' => '',
}

fast_10u = {
  '10UF1' => '',
  '10UF2' => '',
  '10UF3' => '',
  '10UF4' => '',
  '10UF5' => '',
  '10UF6' => '',
  '10UF7' => '',
  '10UF8' => '',
  # '10UF9' => '',
  # '10UF10' => '',
  # '10UF11' => '',
}

fast_12u = {
  '12UF1' => '',
  '12UF2' => '',
  '12UF3' => '',
  '12UF4' => '',
  '12UF5' => '',
  '12UF6' => '',
}

fast_14u = {
  '14UF1' => '',
  '14UF2' => '',
  '14UF3' => '',
  '14UF4' => '',
  '14UF5' => '',
  '14UF6' => '',
  '14UF7' => '',
}

fast_15_plus = {
  '15F1' => '',
  '15F2' => '',
  '15F3' => '',
  '15F4' => '',
  # '15F5' => '',
  # '15F6' => '',
  # '15F7' => '',
}

slow_10u = {
  '10US1' => '',
  '10US2' => '',
  '10US3' => '',
  # '11US4' => '',
}

slow_12u = {
  '12US1' => '',
  '12US2' => '',
  '12US3' => '',
  # '12US4' => '',
}

slow_14u = {
  '14US1' => '',
  '14US2' => '',
  '14US3' => '',
  # '14US4' => '',
  # '14US5' => '',
}

slow_19u = {
  '19US1' => '',
  '19US2' => '',
  '19US3' => '',
  # '19US4' => '',
  # '19US5' => '',
  # '19US6' => '',
}

leagues = [sugar_and_spice, senior_sugar_and_spice, universal_8u, fast_10u, fast_12u, fast_14u, fast_15_plus, slow_10u, slow_12u, slow_14u, slow_19u]

leagues.each do |teams|
  teams.each do |abbreviation, name|
    Team.find_or_create_by_abbreviation abbreviation
  end
end
