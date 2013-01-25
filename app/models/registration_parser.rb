require 'csv'

class RegistrationParser
  
  def initialize file
    @file = file
    @headers = nil
  end
  
  def parse
    list = RegistrationList.new
    CSV.foreach(@file) do |row|
      look_for_headers_in(row) if @headers.nil?
      unless is_registration_data?(row)
        next
      end
      
      list << create_registration_from(row)
    end
    
    list
  end
  
  protected

  def look_for_headers_in row
    if row.any? && row[0] == 'Record ID'
      @headers = row
    end
  end

  def is_registration_data? row
    row.any? && row.compact.size > 1 && row[0] != 'Record ID'
  end
  
  def create_registration_from row
    data = []
    row.each_with_index do |col, index|
      data << [@headers[index], col]
    end 
    Registration.create_from! Hash[data]
  end
end