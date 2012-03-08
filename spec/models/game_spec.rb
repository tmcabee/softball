require 'spec_helper'

describe Game do
  describe 'duration' do
    it "should be 60 minutes for a Sugar/Spice team" do
      game = FactoryGirl.build :game, :home_team => FactoryGirl.create(:team, :abbreviation => 'SS1')
      game.duration.should eq(60.minutes)
    end

    it "should be 60 minutes for a Senior Sugar/Spice team" do
      game = FactoryGirl.build :game, :home_team => FactoryGirl.create(:team, :abbreviation => 'SRSS1')
      game.duration.should eq(60.minutes)
    end

    it "should be 60 minutes for a 8U team" do
      game = FactoryGirl.build :game, :home_team => FactoryGirl.create(:team, :abbreviation => '8U1')
      game.duration.should eq(60.minutes)
    end

    it "should be 75 minutes for any other team" do
      game = FactoryGirl.build :game, :home_team => FactoryGirl.create(:team, :abbreviation => 'blah')
      game.duration.should eq(75.minutes)
    end

    describe "hacks until we can confirm the schedule is right" do
      it "should be 60 minutes for a 10UF team that plays at 6:15PM" do
        game = FactoryGirl.build :game, :home_team => FactoryGirl.create(:team, :abbreviation => '10UF1'), :start_time => DateTime.strptime("03-07-2012 18:15", '%m-%d-%Y %H:%M')
        game.duration.should eq(60.minutes)
      end

      it "should be 60 minutes for a 10US team that plays at 6:15PM" do
        game = FactoryGirl.build :game, :home_team => FactoryGirl.create(:team, :abbreviation => '10US1'), :start_time => DateTime.strptime("03-07-2012 18:15", '%m-%d-%Y %H:%M')
        game.duration.should eq(60.minutes)
      end

      it "should be 60 minutes for a 10US team that plays on a weekend" do
        game = FactoryGirl.build :game, :home_team => FactoryGirl.create(:team, :abbreviation => '10US1'), :start_time => DateTime.strptime("03-10-2012 10:00", '%m-%d-%Y %H:%M')
        game.duration.should eq(60.minutes)
      end

      it "should be 75 minutes for a 10UF team that plays on a weekend" do
        game = FactoryGirl.build :game, :home_team => FactoryGirl.create(:team, :abbreviation => '10UF1'), :start_time => DateTime.strptime("03-10-2012 10:00", '%m-%d-%Y %H:%M')
        game.duration.should eq(75.minutes)
      end
    end
  end
end

