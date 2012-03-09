FactoryGirl.define do
  factory :game do |game|
    game.start_time { 1.hour.from_now }
    association :home_team, :factory => :team
    association :away_team, :factory => :team
    association :field,     :factory => :field
    game.unique_id  { |g| "#{g.start_time.strftime("%Y%m%d%H%M")}#{g.field.number}" }
  end
end