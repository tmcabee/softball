class Team < ActiveRecord::Base
  validates_presence_of :abbreviation, :name
end
