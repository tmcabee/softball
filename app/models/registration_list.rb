class RegistrationList

  BLANK_LINES = 20

  class Divisions
  	SS    = { :abbreviation => 'SS',   :key => 'Sugar & Spice' }
  	SSS   = { :abbreviation => 'SSS',  :key => 'Senior Sugar & Spice', :play_up_from => SS }
  	FP8U  = { :abbreviation => '8U',   :key => '8U Universal',         :play_up_from => SSS }
  	FP10U = { :abbreviation => '10UF', :key => '10U Fast-Pitch',       :play_up_from => FP8U }
	  FP12U = { :abbreviation => '12UF', :key => '12U Fast-Pitch',       :play_up_from => FP10U }
	  FP14U = { :abbreviation => '14UF', :key => '14U Fast-Pitch',       :play_up_from => FP12U }
	  FP15  = { :abbreviation => '15F',  :key => '15+ Fast-Pitch',       :play_up_from => FP14U }
	  SP11U = { :abbreviation => '11US', :key => '11U Slow-Pitch' }
	  SP14U = { :abbreviation => '14US', :key => '14U Slow-Pitch',       :play_up_from => SP11U }
	  SP19U = { :abbreviation => '19US', :key => '19U Slow-Pitch',       :play_up_from => SP14U }
  end

  def initialize
  	@registrations = []
  end
  
  def << registration
  	@registrations << registration
  end

  def master_list
  	headers = Registration::Format::MASTER
    to_csv headers do
      @registrations.sort_by { |reg| "#{reg[headers[0]]}|#{reg[headers[1]]}" }
    end
  end

  def league_director_list_for division
  	csv_for division, Registration::Format::LD
  end

  def coaches_list_for division
  	csv_for division, Registration::Format::COACHES
  end

  protected

  def divisions
    @divisions ||= @registrations.group_by { |reg| reg['Registration Title']}
  end

  def csv_for division, headers
  	to_csv headers do
  	  normal = divisions[division[:key]].select { |reg| division[:abbreviation] == '14US' || reg['PlayUpRequest'] != 'Checked' }
  	  play_ups = division[:play_up_from] ? divisions[division[:play_up_from][:key]].select { |reg| reg['PlayUpRequest'] == 'Checked' } : []

      message = "For #{division[:abbreviation]}, adding #{normal.size} normal" 
      message += " and #{play_ups.size} play-ups from #{division[:play_up_from][:abbreviation]}" if play_ups.any?
      puts message

  	  (normal + play_ups).sort_by { |reg| "#{reg[headers[0]]}|#{reg[headers[1]]}" }
  	end
  end

  def to_csv headers, &registrations
  	content = registrations.call
  	index = 0
  	([(['Num'] + headers).join(',')] + content.map { |registration| registration.to_csv((index += 1), headers) } + blanks(index+1)).join("\n")
  end

  def blanks index
  	(index..index+BLANK_LINES).to_a
  end
end
