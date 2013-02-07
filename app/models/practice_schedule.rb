class PracticeSchedule < ActiveRecord::Base
  has_many :practices
  
  def find_missing_practices_and_cancel!
    Practice.where(:practice_schedule_id => id-1).update_all :canceled => true, :practice_schedule_id => id
  end
  
  def to_csv
    practices.map(&:to_csv).join("\n")
  end
end
