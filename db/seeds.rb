# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[1,2,3,4,5,6].each do |field_number|
  Field.find_or_create_by_number_and_description field_number, "Lost Mt. Field ##{field_number}"
end

sugar_and_spice = {
  'SS1' => 'SS1 - Roberson',
  'SS2' => 'SS2 - Clontz',
  'SS3' => 'SS3 - Paul',
  'SS4' => 'SS4 - Isley',
  'SS5' => 'SS5 - Wolfe',
  'SS6' => 'SS6 - Open',
}

# senior_sugar_and_spice = {
#   'SRSS1' => 'SRSS1 Pendergrass',
#   'SRSS2' => 'SRSS2 Thomas',
#   'SRSS3' => 'SRSS3 Lovett',
#   'SRSS4' => 'SRSS4 Mitchell',
#   'SRSS5' => 'SRSS5 Clontz',
#   'SRSS6' => 'SRSS6  Redden',
# }

universal_8u = {
  '8U1' => '8U1 - Chauvin',
  '8U2' => '8U2 - Edwards',
  '8U3' => '8U3 - Feyerbend',
  '8U4' => '8U4 - Gilstrap',
  '8U5' => '8U5 - McAbee',
  '8U6' => '8U6 - Mitchell',
  '8U7' => '8U7 - Thomas',
  '8U8' => '8U8 - Volckmann',
  '8U9' => '8U9 - Knight',
}

slow_10u = {
  '10US1' => '10US1 - Open',
  '10US2' => '10US2 - Open',
  '10US3' => '10US3 - Open',
}

fast_10u = {
  '10UF1' => '10UF1 - Stroud',
  '10UF2' => '10UF2 - Moore',
  '10UF3' => '10UF3 - Bartley',
  '10UF4' => '10UF4 - Hambrick',
  '10UF5' => '10UF5 - Murphy',
  '10UF6' => '10UF6 - Knight',
  '10UF7' => '10UF7 - Botts',
  '10UF8' => '10UF8 - Mueller',
  '10UF9' => '10UF9 - Head',
  '10UF10' => '10U10 - Turpin',
}

# slow_12u = {
#   '12US1' => '12US1 Lamb',
#   '12US2' => '12US2 Belinfante',
#   '12US3' => '12US3 Gilleland',
#   '12US4' => '12US4 Brown',
# }

fast_12u = {
  '12UF1' => '12UF1 - Mobley',
  '12UF2' => '12UF2 - Santiago',
  '12UF3' => '12UF3 - Peridies',
  '12UF4' => '12UF4 - Robertson',
  '12UF5' => '12UF5 - Venable',
}

slow_14u = {
  '14US1' => '14US1 - Open',
  '14US2' => '14US2 - Open',
  '14US3' => '14US3 - Open',
  '14US4' => '14US4 - Open',
  '14US5' => '14US5 - Open',
}

fast_14u = {
  '14UF1' => '14UF1 - Schmidt',
  '14UF2' => '14UF2 - Bloye',
  '14UF3' => '14UF3 - Open',
  '14UF4' => '14UF4 - Open',
}

fast_15_plus = {
  '15F1' => '15F1 - Millwood',
  '15F2' => '15F2 - Bowman',
  '15F3' => '15F3 - Open',
}

slow_19u = {
  '19US1' => '19US1 - Hipps',
  '19US2' => '19US2 - Morgan',
  '19US3' => '19US3 - Tucker',
  '19US4' => '19US4 - Mitchell',
  '19US5' => '19US5 - Williams',
}

leagues = [sugar_and_spice, universal_8u, slow_10u, fast_10u, fast_12u, slow_14u, fast_14u, fast_15_plus, slow_19u]

leagues.each do |teams|
  teams.each do |abbreviation, name|
    Team.find_or_create_by_abbreviation_and_name abbreviation, name
  end
end
