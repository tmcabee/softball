require 'csv'

class PracticeScheduleParser
  
  module Mode
    FIELDS  = :fields
    GAMES   = :games
    TIMES   = :times
  end

  def initialize file
    @file = file
    @mode = Mode::FIELDS
    @date = nil
    @times = nil
    @fields = nil
    version = @file.match(/.*ver_(.*).csv/)[1]
    @schedule = PracticeSchedule.where(:version => version).first_or_create!
  end
  
  def parse
    CSV.foreach(@file) do |row|
      unless row.any?
        @mode = Mode::FIELDS
        @date = nil
        next
      end
      
      # puts "mode: #{@mode}"

      case @mode
      when Mode::FIELDS
        @date = row[0] if row[0]
        @fields = row[1..-1]
        @mode = Mode::TIMES
      when Mode::TIMES
        @times = row[1..-1]
        @mode = Mode::GAMES
      when Mode::GAMES
        @date = row[0] if row[0]
        create_games_from row[1..-1]
        @mode = Mode::TIMES
      end
    end
    
    @schedule
  end
  
  protected
  
  #TODO: Parse season so I can stop hard-coding '2012'
  def create_games_from row
    # puts "times: #{@times}"
    # puts "row: #{row}"
    row.each_with_index do |col, index|
      next unless col
      next if ['empty','open'].include?(col.downcase)
      teams = col.split('/')
      teams.each do |team|
        # puts @date
        # puts @times[index]
        # puts field_number(@fields[index])
        # puts team
        other_teams = teams-[team]
        # puts "Share field with #{other_teams.join(',')}" if other_teams.any?
        # puts "--------------END-----------"
        Practice.create_from! @schedule, start_time('2014', @date, time_with_meridiem(@times[index])), field_number(@fields[index]), team, other_teams
      end
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