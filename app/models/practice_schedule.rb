class PracticeSchedule < ActiveRecord::Base
  has_many :practices
  
  # def find_missing_games_and_cancel!
  #   Game.where(:schedule_id => id-1).update_all :canceled => true, :schedule_id => id
  # end
  
  def to_csv
    practices.map(&:to_csv).join("\n")
  end
end
