#TODO: Tie to a season, since teams will need to change each season
#TODO: Tie to a league (ie, 8U, 10US, 10UF, etc) so I can infer some of the abbreviation and/or name
class Team < ActiveRecord::Base
  validates_presence_of :abbreviation, :name
  
  has_many :home_games, :class_name => 'Game', :foreign_key => 'home_team_id'
  has_many :away_games, :class_name => 'Game', :foreign_key => 'away_team_id'
  
  def games
    Game.for_team(self)
  end
end
