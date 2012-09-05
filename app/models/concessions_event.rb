class ConcessionsEvent < ActiveRecord::Base
  belongs_to :team
  belongs_to :concessions_schedule
  
  validates_presence_of :unique_id, :concessions_schedule, :start_time, :team
  validates_uniqueness_of :unique_id

  TYPE = 'Concession Duty'
  FACILITY = 'UPPER_CONCESSIONS'
  
  def self.create_from! concessions_schedule, date_time, team
    attributes = {
      :unique_id  => "#{date_time.strftime("%Y%m%d%H%M")}C#{team}",
      :concessions_schedule   => concessions_schedule,
      :start_time => date_time,
      :team       => Team.find_by_abbreviation(team),
      :canceled   => false
    }
    # puts ConcessionsEvent.new(attributes).to_csv
    event = ConcessionsEvent.where(attributes.slice(:unique_id)).first_or_initialize
    event.update_attributes! attributes
  end

  def to_csv
    [ unique_id,
      date,
      military_start_time,
      military_end_time,
      team.abbreviation,
      FACILITY,
      TYPE,
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
    ['Sat','Sun'].include?(start_time.strftime("%a")) ? 165.minutes : 195.minutes
  end
end
