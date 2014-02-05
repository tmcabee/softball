class RegistrationList

  BLANK_LINES = 20

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
    division.abbreviation == '19US' ? Registration::DraftFormat::LD_19U : Registration::DraftFormat::LD
  end

  def registrations master_sheet = false
    return @registrations unless @options.include? 'make_up'
    @registrations.select { |reg| reg.rating_required? && reg.rating_missing? }
  end

  def divisions
    @divisions ||= registrations.group_by { |reg| reg['Registration Title']}
  end

  def draft_data_for division, headers
    to_csv headers do
      divisions[division.key].sort_by { |reg| [-reg['Rating'], reg['Last Name'], reg['First Name']] }
    end
  end

  def skills_data_for division, headers
  	to_csv headers do
  	  normal, playing_up = (divisions[division.key] || []).partition { |reg| division.abbreviation == '14US' || reg['PlayUpRequest'] != 'Checked' }
  	  playing_up_from_lower = division.play_up_from && divisions[division.play_up_from.key] ? divisions[division.play_up_from.key].select { |reg| reg['PlayUpRequest'] == 'Checked' } : []

      message = "For #{division.abbreviation}, adding #{normal.size} normal" 
      # message += ", #{playing_up.size} play-ups from #{division.abbreviation}" if playing_up.any?
      message += ", #{playing_up_from_lower.size} play-ups from #{division.play_up_from.abbreviation}" if playing_up_from_lower.any?
      puts message

  	  # (normal + playing_up + playing_up_from_lower).sort_by { |reg| [reg['Last Name'], reg['First Name']] }
      (normal + playing_up_from_lower).sort_by { |reg| [reg['Last Name'], reg['First Name']] }
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
