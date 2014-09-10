#TODO: Tie to a season, since teams will need to change each season
#TODO: Tie to a league (ie, 8U, 10US, 10UF, etc) so I can infer some of the abbreviation and/or name
class Team < ActiveRecord::Base
  validates_presence_of :abbreviation
  
  has_many :home_games, :class_name => 'Game', :foreign_key => 'home_team_id'
  has_many :away_games, :class_name => 'Game', :foreign_key => 'away_team_id'
  has_one :concessions_event

  def games
    Game.for_team(self)
  end

  def practices
    Practice.for_team(self)
  end

  def opponents
    games.group_by { |g| g.opponent_of(self) }.map { |opponent,games| "#{opponent.abbreviation} - #{games.size}" }
  end

  def opponent_summary
    "#{abbreviation} - #{opponents}"
  end

  def game_summary
    "#{abbreviation} - #{games.count} (H - #{home_games.count}, A - #{away_games.count})"
  end

  def schedule_summary
    "#{game_summary} : #{opponents}"
  end

  def double_headers
    games.group_by { |g| g.date }.map { |date,games| date if games.size > 1 }.compact
  end
end
