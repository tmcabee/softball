require 'date'

class Parser
  
  def initialize document
    @doc = document
  end
  
  def parse
    hash = Hash.new
    year = @doc.at_css("title").text.split(' ').first

    doc.css("table:nth-child(9) tr").each_with_index do |row, row_index|
      row.css("td").each_with_index do |element, col_index|
        item = element.at_css("span")
        text = item ? item.text : ''
        if col_index == 0 
          if text.empty?
            text = hash[[row_index-1][col_index]] unless row_index == 0
          else
            text = formatted_date(year, text)
          end
        end

        hash[[row_index, col_index]] = text
      end
    end

    hash
  end
  
  protected
  
  def formatted_date year, date_str
    Date.strptime("#{year} #{date_str}", '%Y %a %m/%d').strftime("%Y%m%d")
  end
end
