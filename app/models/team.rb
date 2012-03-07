class Team < ActiveRecord::Base
  validates_presence_of :abbreviation, :name
  
  has_many :home_games, :class_name => 'Game', :foreign_key => 'home_team_id'
  has_many :away_games, :class_name => 'Game', :foreign_key => 'away_team_id'
  
  def games
    Game.for_team(self)
  end
end
