require 'spec_helper'

describe "games/edit" do
  before(:each) do
    @game = assign(:game, stub_model(Game,
      :unique_id => "MyString",
      :schedule_id => 1,
      :field_id => 1,
      :home_team_id => 1,
      :away_team_id => 1,
      :canceled => false
    ))
  end

  it "renders the edit game form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => games_path(@game), :method => "post" do
      assert_select "input#game_unique_id", :name => "game[unique_id]"
      assert_select "input#game_schedule_id", :name => "game[schedule_id]"
      assert_select "input#game_field_id", :name => "game[field_id]"
      assert_select "input#game_home_team_id", :name => "game[home_team_id]"
      assert_select "input#game_away_team_id", :name => "game[away_team_id]"
      assert_select "input#game_canceled", :name => "game[canceled]"
    end
  end
end
