class Game < ActiveRecord::Base
  belongs_to :home_team, :class_name => 'Team'
  belongs_to :away_team, :class_name => 'Team'

  validates_presence_of :game_id, :field_number, :date, :start_time, :end_time, :home_team, :away_team
end
