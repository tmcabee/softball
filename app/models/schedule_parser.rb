require 'csv'

module Mode
  VERSION = :version
  DATE    = :date
  FIELDS  = :fields
  TIMES   = :times
  GAMES   = :games
end

class ScheduleParser
  
  def initialize file
    @file = file
    @mode = Mode::VERSION
  end
  
  def parse
    schedule = nil
    date = nil
    fields = nil
    times = nil

    CSV.foreach(@file) do |row|
      case @mode
      when Mode::VERSION
        if row[2] && row[2] =~ /Version/
          version = row[2].scan(/Version (\w+).*/).flatten.first
          schedule = Schedule.first_or_create! :version => version
          @mode = Mode::DATE
        end
      when Mode::DATE
        if row[0]
          date = row[0]
          @mode = Mode::FIELDS
        end
      when Mode::FIELDS
        if row.size > 0
          fields = row
          @mode = Mode::TIMES
        else
          @mode = Mode::DATE
        end
      when :times
        if row.size > 0
          times = row
          @mode = Mode::GAMES
        else
          @mode = Mode::DATE
        end
      when :games
        row.each_with_index do |col, index|
          unless col.nil?
            home, away = col.split("VS.")
            next unless away
            Game.create_from! schedule, parsed_date('2012', date, time_with_meridiem(times[index])), field_number(fields[index]), sanitize(home), sanitize(away)
          end
        end 
        @mode = Mode::TIMES
      end
    end
  end
  
  protected
  
  def time_with_meridiem time
    hour, minutes = time.split(':')
    meridiem = (hour.to_i == 12 || hour.to_i < 9) ? "PM" : "AM"
    "#{time} #{meridiem}"
  end

  def parsed_date year, date, time
    DateTime.strptime("#{year} #{date} #{time}", '%Y %a %m/%d %I:%M %p')
  end

  def field_number field
    field.split(' ').last
  end

  def sanitize team
    team.gsub('*','').strip
  end
  
end