  class Registration

  CURRENT_SEASON = '2015 Spring'

  class Format
    MASTER = ['Record ID', 'Last Name', 'First Name', 'Have Concession Check', 'Balance', 'Deposit Check Received', 'Registration Title', 'Birthday', 'PlayUpRequest', 'ConcessionRequirement', 'CC Invoice', 'Check No.', 'Cost', 'Paid', 'Waitlisted', 'Notes']
    COACHES = ['Last Name', 'First Name', 'Birthday', 'Play-up Candidate', 'Hitting', 'Running', 'Fielding', 'Throwing', 'TOTAL', 'Pitching', 'Catching', 'Skills Notes']
    LD = ['Last Name', 'First Name', 'Birthday', 'Have Concession Check', 'Balance', 'Waitlisted', 'Play-up Candidate', 'Skills Notes']
  end

  class DraftFormat
    COACHES = ['Last Name', 'First Name', 'Address 1', 'Rating', 'Birthday', 'Age', 'WCGS', 'Other', 'All-Star', 'Travel', 'Positions', 'Special', 'CoachRequestName', 'PlayerRequestNames', 'JerseySize']
    LD = ['Record ID'] + COACHES + ['ConfidentialCoachName']
    COACHES_19U = ['Last Name', 'First Name', 'Address 1', 'Birthday', 'Age', 'School', 'WCGS', 'Other', 'All-Star', 'Travel', 'Positions', 'Special', 'CoachRequestName', 'PlayerRequestNames', 'JerseySize']
    LD_19U = ['Record ID'] + COACHES_19U + ['ConfidentialCoachName']
  end

  def self.create_from! attributes
    new attributes
  end
  
  def to_csv index, headers
    ([index] + headers.map do |column_name| 
      value = @attributes[column_name]
      value.is_a?(String) ? "\"#{value}\"" : value
    end).join(',')
  end

  def [] column_name
    @attributes[column_name]
  end
  
  def []=(column_name, value)
    @attributes[column_name] = value
  end

  def rating_missing?
    @attributes['Rating'].to_i == 0.0
  end

  def rating_required?
    not_required = @attributes['Registration Title'] == "Sugar & Spice" && @attributes['Play-up Candidate'].blank?

    !not_required
  end

  protected

  def initialize attributes
    @division ||= Division.find_by_key registration_title(attributes['Registration Title'])
    @attributes = sanitized attributes
  end

  def division
    @division
  end

  def registration_title original_title
    original_title.gsub(" (#{CURRENT_SEASON})", "")
  end

  def sanitized original
    original.dup.tap do |attrs|
      attrs['Registration Title'] = registration_title original['Registration Title']
      attrs['ConcessionRequirement'] = concession_requirement_field(original['ConcessionRequirement'])
      attrs['Play-up Candidate'] = original['PlayUpRequest'] == 'Checked' ? 'X' : ''
      attrs['Waitlisted'] = on_waitlist?(original) ? 'X' : ''
      attrs['Have Concession Check'] = need_concession_check?(original) ? '' : 'X'
      raw_rating = "#{original['Rating'].to_i}.#{original['Weight'].to_i}".to_f
      attrs['Rating'] = raw_rating
      attrs['WCGS'] = experience_value_of original['ExperienceWCGS']
      attrs['Other'] = experience_value_of original['ExperienceOther']
      attrs['All-Star'] = experience_value_of original['ExperienceAllStar']
      attrs['Travel'] = experience_value_of original['ExperienceTravel']
      experience = []
      experience << 'P' if !original['Pitcher'].blank?
      experience << 'C' if !original['Catcher'].blank?
      experience << 'IF' if !original['Infield'].blank?
      experience << 'OF' if !original['Outfield'].blank?
      attrs['Positions'] = experience.join(',')
      attrs['Age'] = age(original['Birthday'])
      balance = original['Cost'].to_i - original['Paid'].to_i
      attrs['Balance'] = balance unless balance.zero?
      attrs['Skills Notes'] = "Attempting to play up to #{division.play_up_to.key}" if original['PlayUpRequest'] == 'Checked'
      # attrs['Rating'] = 0.0 if division.no_skills_test?
    end
  end

  def now
    @now ||= Time.now.utc.to_date
  end

  def age date_string
    return "" if date_string.blank?
    dob = Date.strptime(date_string, "%m/%d/%Y")
    age = (now-dob).to_i/365.0
    sprintf("%.1f", age)
  end

  def experience_value_of attribute
    return '' if attribute.nil?
    attribute == 'None' ? '' : attribute.split(' ').first
  end

  def concession_requirement_field value
    return if value.blank?
    value =~ /NON-refundable fee/ ? 'Fee' : 'Deposit'
  end

  def on_waitlist? attributes
    attributes['Waitlisted'] == 'True'
  end

  def need_concession_check? attributes
    # return false if on_waitlist?(attributes)
    attributes['ConcessionRequirement'] =~ /deposit$/ && attributes['Deposit Check Received'].blank?
  end

  def need_payment? attributes
    attributes['Paid'].to_i < attributes['Cost'].to_i
  end
end
