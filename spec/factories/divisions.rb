# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :division do
    abbreviation "MyString"
    key "MyString"
    play_up_id 1
    play_up_from_id 1
  end
end
