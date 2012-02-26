class ScheduleData

  DATE_COLUMN = 0
  TIME_COLUMN = 1
  
  def self.create_from document
    new Parser.new(document).parse
  end

  def initialize data
    @data = data
  end
  protected :initialize

  def events
    last_row = @data.keys.max.first
    last_col = @data.keys.max.last
    
    response = []
    (2..last_col).each do |column|
      (0..last_row).to_a.product([column]).each_with_index do |key, row|
        field = @data[[0, column]]
        response << Event.new 
      end
    end
    
    response
  end
end
