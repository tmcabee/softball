require 'spec_helper'

describe Team do
  it "requires abbreviation" do
    team = FactoryGirl.build(:team, :abbreviation => nil)
    assert_equal false, team.valid?
    assert_equal ["can't be blank"], team.errors[:abbreviation]
  end

  it "requires name" do
    team = FactoryGirl.build(:team, :name => nil)
    assert_equal false, team.valid?
    assert_equal ["can't be blank"], team.errors[:name]
  end
end

