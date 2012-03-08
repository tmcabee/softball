require 'rubygems'
require 'csv'

def time_with_meridiem time
  hour, minutes = time.split(':')
  # puts "parsing #{hour}"
  if hour.to_i == 12 || hour.to_i < 9
    return "#{time} PM"
  end
  return "#{time} AM"
end

def parsed_date year, date, time
  date = DateTime.strptime("#{year} #{date} #{time}", '%Y %a %m/%d %I:%M %p')
end

def field_number field
  field.split(' ').last
end

def sanitize team
  team.gsub('*','').strip
end

file = File.join File.dirname(__FILE__), 'schedule_ver_3a.csv'

mode = :version
schedule = nil
date = nil
fields = nil
times = nil
CSV.foreach(file) do |row|
  if mode == :version
    if row[2] && row[2] =~ /Version/
      version = row[2].scan(/Version (\w+).*/).flatten.first
      schedule = Schedule.first_or_create! :version => version
      mode = :date
    end
  elsif mode == :date
    if row[0]
      date = row[0]
      mode = :fields
    end
  elsif mode == :fields
    if row.size > 0
      fields = row
      mode = :times
    else
      mode = :date
    end
  elsif mode == :times
    if row.size > 0
      times = row
      mode = :games
    else
      mode = :date
    end
  elsif mode == :games
    row.each_with_index do |col, index|
      unless col.nil?
        home, away = col.split("VS.")
        next unless away
        Game.create_from! schedule, parsed_date('2012', date, time_with_meridiem(times[index])), field_number(fields[index]), sanitize(home), sanitize(away)
      end
    end 
    mode = :times
  end
  
end

