require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  test "abbreviation is required" do
    team = FactoryGirl.build(:team, :abbreviation => nil)
    assert_equal false, team.valid?
    assert_equal ["can't be blank"], team.errors[:abbreviation]
  end

  test "name is required" do
    team = FactoryGirl.build(:team, :name => nil)
    assert_equal false, team.valid?
    assert_equal ["can't be blank"], team.errors[:name]
  end
end
