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
  'SS1' => 'SS1 Matthews',
  'SS2' => 'SS2 Isley',
  'SS3' => 'SS3 Paul',
  'SS4' => 'SS4 Roberson',
  'SS5' => 'SS5 Goodwin',
  'SS6' => 'SS6 Zirpoly',
}

senior_sugar_and_spice = {
  'SRSS1' => 'SRSS1 Pendergrass',
  'SRSS2' => 'SRSS2 Thomas',
  'SRSS3' => 'SRSS3 Lovett',
  'SRSS4' => 'SRSS4 Mitchell',
  'SRSS5' => 'SRSS5 Clontz',
  'SRSS6' => 'SRSS6  Redden',
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

slow_10u = {
  '10US1' => '10US1 Walters',
  '10US2' => '10US2Bennett',
  '10US3' => '10US3 Stancil',
  '10US4' => '10US4 Johnson',
  '10US5' => '10US5 Martin',
}

fast_10u = {
  '10UF1' => 'FP10U1 Moore',
  '10UF2' => 'FP10U2 Head',
  '10UF3' => 'FP10U3 Smith',
  '10UF4' => 'FP10U4 Turpin',
  '10UF5' => 'FP10U5 Knight',
  '10UF6' => 'FP10U6 Mobley',
  '10UF7' => 'FP10U7 Bennett',
  '10UF8' => 'FP10U8 Botts',
  '10UF9' => 'FP10U9 Santiago',
}

slow_12u = {
  '12US1' => '12US1 Lamb',
  '12US2' => '12US2 Belinfante',
  '12US3' => '12US3 Gilleland',
  '12US4' => '12US4 Brown',
}

fast_12u = {
  '12UF1' => 'FP12U1 Hogg',
  '12UF2' => 'FP12U2 Venable',
  '12UF3' => 'FP12U3 McCallister',
  '12UF4' => 'FP12U4 Hunt',
  '12UF5' => 'FP12U5 Hill',
  '12UF6' => 'FP12U6 Cook',
  '12UF7' => 'FP12U7 Dorrough',
}

slow_14u = {
  '14US1' => '14US1 Harris',
  '14US2' => '14US2 Belinfante',
  '14US3' => '14US3 Gilleland',
  '14US4' => '14US4 Lovinggood',
}

fast_14u = {
  '14UF1' => 'FP14U1 McClung',
  '14UF2' => 'FP14U2 Cox',
  '14UF3' => 'FP14U3 Hambrick',
  '14UF4' => 'FP14U4 Sirmans',
  '14UF5' => 'FP14U5 Garcia',
  '14UF6' => 'FP14U6 Gross',
  '14UF7' => 'FP14U7  Bloye',
}

fast_15_plus = {
  '15F1' => 'FP15U+1 Waters',
  '15F2' => 'FP15U+2 Defreese',
  '15F3' => 'FP15U+3 Guthrie',
  '15F4' => 'FP15+ 4 Bowman',
  '15F5' => 'FP15+5 Mirabelli',
}

slow_19u = {
  '19US1' => '19U1 Tucker',
  '19US2' => '19U2 Morgan',
  '19US3' => '19U3 Matthews',
  '19US4' => '19U4 Mitchell',
  '19US5' => '19U5 Kuglar',
  '19US6' => '19U6 Hipps',
  '19US7' => '19U7 Murphy',
  '19US8' => 'Ryan Park',
}

leagues = [sugar_and_spice, senior_sugar_and_spice, universal_8u, slow_10u, fast_10u, slow_12u, fast_12u, slow_14u, fast_14u, fast_15_plus, slow_19u]

leagues.each do |teams|
  teams.each do |abbreviation, name|
    Team.find_or_create_by_abbreviation_and_name abbreviation, name
  end
end
