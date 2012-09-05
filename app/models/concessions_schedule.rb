class ConcessionsSchedule < ActiveRecord::Base
  has_many :concessions_events
  
  def to_csv
    concessions_events.map(&:to_csv).join("\n")
  end
end
