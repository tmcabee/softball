class Game < ActiveRecord::Base
  belongs_to :home_team, :class_name => 'Team'
  belongs_to :away_team, :class_name => 'Team'
  belongs_to :field
  belongs_to :schedule
  
  validates_presence_of :unique_id, :schedule, :field, :start_time, :home_team, :away_team
  validates_uniqueness_of :unique_id

  TYPE = 'Game'
  
  scope :for_team, lambda{ |team| 
    { :conditions => ["home_team_id = ? or away_team_id=?", team.id, team.id] }
  }

  def self.create_from! schedule, date_time, field_number, home, away
    attributes = {
      :unique_id  => "#{date_time.strftime("%Y%m%d%H%M")}#{field_number}",
      :schedule   => schedule,
      :start_time => date_time,
      :field      => Field.find_by_number(field_number),
      :home_team  => Team.find_by_abbreviation(home),
      :away_team  => Team.find_by_abbreviation(away)
    }
    game = Game.where(attributes.slice(:unique_id)).first_or_initialize
    game.update_attributes! attributes
  end
  
  def to_csv
    [ unique_id,
      date,
      military_start_time,
      military_end_time,
      home_team.name,
      field.description,
      TYPE,
      away_team.name,
      '',
      canceled_text ].join(',')
  end
  
  def date
    start_time.strftime("%m-%d-%Y")
  end
  
  def military_start_time
    start_time.strftime("%H:%M")
  end
  
  def military_end_time
    (start_time + duration).strftime("%H:%M")
  end
  
  def canceled_text
    canceled? ? 'CANCELLED' : ''
  end

  #TODO: Confirm these hacks are necessary
  def duration
    return 60.minutes if home_team.abbreviation =~ /^(SS|SRSS|8U)/ # Once hacks below are removed, 10US should be added to this list
    return 60.minutes if home_team.abbreviation =~ /^10U/ && military_start_time == "18:15" # HACK: 10UF games should be 75 minutes
    return 60.minutes if home_team.abbreviation =~ /^10US/ && ['Sat','Sun'].include?(start_time.strftime("%a")) # HACK: 10US games should be 60 regardless of weekday/weeknight
    75.minutes
  end
end
