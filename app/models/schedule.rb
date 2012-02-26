class Schedule
  def self.create_from document
    new ScheduleData.create_from(document).events
  end

  def initialize events
    @events = events
  end
  protected :initialize

  def to_csv
    file = File.new("practice_schedule.csv", "w") do
      @events.each do |event|
        file.puts event.to_csv_string
      end
    end
  end
end
