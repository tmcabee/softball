require 'csv'

class ScheduleParser
  
  module Mode
    VERSION = :version
    DATE    = :date
    FIELDS  = :fields
    TIMES   = :times
    GAMES   = :games
  end

  def initialize file
    @file = file
    @mode = Mode::VERSION
    @schedule = nil
    @date = nil
    @fields = nil
    @times = nil
  end
  
  def parse
    CSV.foreach(@file) do |row|
      unless row.any?
        @mode = Mode::DATE if @schedule
        next
      end
      
      case @mode
      when Mode::VERSION
        identify_schedule_from row
        @mode = Mode::DATE if @schedule
      when Mode::DATE
        @date = row[0]
        @mode = Mode::FIELDS
      when Mode::FIELDS
        @fields = row
        @mode = Mode::TIMES
      when Mode::TIMES
        @times = row
        @mode = Mode::GAMES
      when Mode::GAMES
        create_games_from row
        @mode = Mode::TIMES
      end
    end
    
    @schedule
  end
  
  protected
  
  def identify_schedule_from row
    if row[2] =~ /Version/
      version = row[2].scan(/Version (\w+).*/).flatten.first
      @schedule = Schedule.where(:version => version).first_or_create!
    end
  end
  
  #TODO: Parse season so I can stop hard-coding '2013'
  def create_games_from row
    row.each_with_index do |col, index|
      next unless col
      home, away = col.split("vs.")
      next unless away
      Game.create_from! @schedule, start_time('2013', @date, time_with_meridiem(@times[index])), field_number(@fields[index]), sanitize(home), sanitize(away)
    end 
  end
  
  def start_time year, date, time
    DateTime.strptime("#{year} #{date} #{time}", '%Y %a %m/%d %I:%M %p')
  end

  #ASSUMES: No weekend games start before 9am and no weeknight games start at (or after) 9pm
  #TODO: Pass in date so I'll have 'day of week' info and remove the assumptions above
  def time_with_meridiem time
    hour, minutes = time.split(':')
    meridiem = (hour.to_i == 12 || hour.to_i < 9) ? "PM" : "AM"
    "#{time} #{meridiem}"
  end

  def field_number field
    field.split(' ').last
  end

  def sanitize team
    team.gsub('*','').strip
  end
  
end