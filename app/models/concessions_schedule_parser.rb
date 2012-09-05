require 'csv'

class ConcessionsScheduleParser
  
  module Mode
    GAMES   = :games
  end

  def initialize file
    @file = file
    @schedule = ConcessionsSchedule.where(:version => '1a').first_or_create!
  end
  
  def parse
    CSV.foreach(@file) do |row|
	  create_events_from row
    end
    
    @schedule
  end
  
  protected
  
  #TODO: Parse season so I can stop hard-coding '2012'
  def create_events_from row
  	date = row[0]
  	time = date.match(/^Sat/) ? "8:30 AM" : "5:45 PM"
  	team = row[2]
    ConcessionsEvent.create_from!(@schedule, start_time('2012', date, time), team) unless team == 'Makeup'
    if row[3]
      team = row[4]
      ConcessionsEvent.create_from!(@schedule, start_time('2012', date, '11:15 AM'), team) unless team == 'Makeup'
    end
  end
  
  def start_time year, date, time
    DateTime.strptime("#{year} #{date} #{time}", '%Y %a %m/%d %I:%M %p')
  end
end