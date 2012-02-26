FactoryGirl.define do
  factory :team do |team|
    team.abbreviation  { "20U#{rand(1000).to_s}" }
    team.name { |t| "#{t.abbreviation} Doe" }
  end

  # # This will use the User class (Admin would have been guessed)
  # factory :admin, :class => User do
  #   first_name 'Admin'
  #   last_name  'User'
  #   admin true
  # end
  # 
  # # The same, but using a string instead of class constant
  # factory :admin, :class => 'user' do
  #   first_name 'Admin'
  #   last_name  'User'
  #   admin true
  # end
end