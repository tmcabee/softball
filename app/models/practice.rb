class Practice < ActiveRecord::Base
  belongs_to :team
  belongs_to :field
  belongs_to :practice_schedule
  
  validates_presence_of :unique_id, :practice_schedule, :field, :start_time, :team
  validates_uniqueness_of :unique_id

  TYPE = 'Practice'
  
  scope :for_team, lambda{ |team| 
    { :conditions => ["team_id = ? and canceled=?", team.id, false] }
  }

  def self.create_from! practice_schedule, date_time, field_number, team, other_teams
    note = other_teams.any? ? "Share field with #{other_teams.join(' & ')}" : ""
    attributes = {
      :unique_id  => "#{date_time.strftime("%Y%m%d%H%M")}#{field_number}#{team}",
      :practice_schedule   => practice_schedule,
      :start_time => date_time,
      :field      => Field.find_by_number(field_number),
      :team       => Team.find_by_abbreviation(team),
      :note       => note,
      :canceled   => false
    }
    puts Practice.new(attributes).to_csv
    practice = Practice.where(attributes.slice(:unique_id)).first_or_initialize
    practice.update_attributes! attributes
  end

  def to_csv
    [ unique_id,
      date,
      military_start_time,
      military_end_time,
      team.abbreviation,
      field.description,
      TYPE,
      '',
      note,
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

  def duration
    ['Sat','Sun'].include?(start_time.strftime("%a")) ? 90.minutes : 75.minutes
  end
end
