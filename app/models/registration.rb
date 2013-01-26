class Registration

  class Format
    MASTER = ['Last Name', 'First Name', 'Registration Title', 'Birthday', 'PlayUpRequest', 'ConcessionRequirement', 'Deposit Check Received', 'CC Invoice', 'Check No.', 'Cost', 'Paid', 'Waitlisted', 'Needs Ticket', 'Notes']
    LD = ['Last Name', 'First Name', 'Needs Ticket']
    COACHES = ['Last Name', 'First Name', 'Hitting', 'Running', 'Fielding', 'Throwing', 'TOTAL', 'Pitching', 'Catching', 'Coach Notes']
  end

  def self.create_from! attributes
    new attributes
  end
  
  def to_csv index, headers
    ([index] + headers.map { |column_name| @attributes[column_name] }).join(',')
  end

  def [] column_name
    @attributes[column_name]
  end
  
  protected

  def initialize attributes
    @attributes = sanitized attributes
  end

  def sanitized original
    original.dup.tap do |attrs|
      attrs['Registration Title'] = original['Registration Title'].gsub(" (2013 Spring)", "")
      attrs['ConcessionRequirement'] = concession_requirement_field(original['ConcessionRequirement'])
      attrs['Waitlisted'] = on_waitlist?(original) ? 'Y' : ''
      attrs['Needs Ticket'] = needs_ticket?(original) ? 'YES' : ''
    end
  end

  def concession_requirement_field value
    return if value.blank?
    value =~ /NON-refundable fee/ ? 'Fee' : 'Deposit'
  end

  def on_waitlist? attributes
    attributes['Waitlisted'] == 'True'
  end

  def needs_ticket? attributes
    return false if on_waitlist?(attributes)
    attributes['Paid'].to_i < attributes['Cost'].to_i ||
    attributes['Notes'] =~ /^NEED/ ||
    attributes['ConcessionRequirement'] =~ /deposit$/ && attributes['Deposit Check Received'].blank?
  end
end
