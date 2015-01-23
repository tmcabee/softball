class Division < ActiveRecord::Base
  def no_skills_test?
  	['SS'].include? abbreviation
  end

  def play_up_from
  	Division.find_by_id(id-1) unless abbreviation == 'SS'
  end

  def play_up_to
  	Division.find_by_id(id+1) unless ['15F', '19US'].include?(abbreviation)
  end
end
