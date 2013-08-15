class RegistrationList

  BLANK_LINES = 20

  class Divisions
  	SS    = { :abbreviation => 'SS',   :key => 'Sugar & Spice',                                :number_of_teams => 7 }
  	# SSS   = { :abbreviation => 'SSS',  :key => 'Senior Sugar & Spice', :play_up_from => SS,    :number_of_teams => 4 }
  	FP8U  = { :abbreviation => '8U',   :key => '8U Universal',         :play_up_from => SS,   :number_of_teams => 9 }
  	FP10U = { :abbreviation => '10UF', :key => '10U Fast-Pitch',       :play_up_from => FP8U,  :number_of_teams => 9 }
	  FP13U = { :abbreviation => '13UF', :key => '13U Fast-Pitch',       :play_up_from => FP10U, :number_of_teams => 7  }
	  # FP14U = { :abbreviation => '14UF', :key => '14U Fast-Pitch',       :play_up_from => FP12U, :number_of_teams => 6 }
	  FP14  = { :abbreviation => '14F',  :key => '14+ Fast-Pitch',       :play_up_from => FP13U, :number_of_teams => 4 }
	  SP11U = { :abbreviation => '11US', :key => '11U Slow-Pitch',                               :number_of_teams => 3 }
	  SP14U = { :abbreviation => '14US', :key => '14U Slow-Pitch',       :play_up_from => SP11U, :number_of_teams => 3 }
	  SP19U = { :abbreviation => '19US', :key => '19U Slow-Pitch',       :play_up_from => SP14U, :number_of_teams => 3 }
  end

  def initialize options
  	@registrations = []
    @options = [options]
  end
  
  def << registration
  	@registrations << registration
  end

  def master_list
  	headers = Registration::Format::MASTER
    to_csv headers do
      registrations(true).sort_by { |reg| "#{reg[headers[0]]}|#{reg[headers[1]]}" }
    end
  end

  def league_director_list_for division
  	skills_data_for division, Registration::Format::LD
  end

  def coaches_list_for division
  	skills_data_for division, Registration::Format::COACHES
  end

  def league_director_draft_for division
    draft_data_for division, ld_draft_format_for(division)
  end

  def coaches_draft_for division
    draft_data_for division, Registration::DraftFormat::COACHES
  end

  protected

  def ld_draft_format_for division
    division == Divisions::SP19U ? Registration::DraftFormat::LD_19U : Registration::DraftFormat::LD
  end

  def registrations master_sheet = false
    return @registrations unless @options.include? 'make_up'
    master_sheet ? @registrations.select { |reg| reg.rating_missing? || reg['Needs Ticket'] == 'YES' } : 
                   @registrations.select { |reg| reg.rating_missing? }
  end

  def divisions
    @divisions ||= registrations.group_by { |reg| reg['Registration Title']}
  end

  def draft_data_for division, headers
    to_csv headers do
      divisions[division[:key]].sort_by { |reg| [-reg['Rating'], reg['Last Name'], reg['First Name']] }
    end
  end

  def skills_data_for division, headers
  	to_csv headers do
  	  normal = divisions[division[:key]].select { |reg| division[:abbreviation] == '14US' || reg['PlayUpRequest'] != 'Checked' }
  	  play_ups = division[:play_up_from] && divisions[division[:play_up_from][:key]] ? divisions[division[:play_up_from][:key]].select { |reg| reg['PlayUpRequest'] == 'Checked' } : []

      message = "For #{division[:abbreviation]}, adding #{normal.size} normal" 
      message += " and #{play_ups.size} play-ups from #{division[:play_up_from][:abbreviation]}" if play_ups.any?
      puts message

  	  (normal + play_ups).sort_by { |reg| [reg['Last Name'], reg['First Name']] }
  	end
  end

  def to_csv headers, &records
  	index = 0
  	([(['Num'] + headers).join(',')] + records.call.map { |registration| registration.to_csv((index += 1), headers) } + blanks(index+1)).join("\n")
  end

  def blanks index
  	(index..index+BLANK_LINES).to_a
  end
end
