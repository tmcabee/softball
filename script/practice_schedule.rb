require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://www.wcgsoftball.com/Page.asp?n=49873&snid=jMLDS5O1Y&org=wcgsoftball.com"
schedule = Schedule.create_from Nokogiri::HTML(open(url))
schedule.to_csv