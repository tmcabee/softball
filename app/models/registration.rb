class Registration

  class Format
    MASTER = ['Last Name', 'First Name', 'Registration Title', 'Birthday', 'PlayUpRequest', 'ConcessionRequirement', 'Deposit Check Received', 'CC Invoice', 'Check No.', 'Cost', 'Paid', 'Notes']
    LD = ['Last Name', 'First Name', 'Needs Ticket']
    COACHES = ['Last Name', 'First Name', 'Hitting', 'Running', 'Fielding', 'Throwing', 'TOTAL','Pitching','Catching']
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

  def sanitized attributes
    attributes.dup.tap do |attrs|
      attrs['Registration Title'] = attributes['Registration Title'].gsub(" (2013 Spring)", "")
      attrs['ConcessionRequirement'] = concession_requirement_field(attributes['ConcessionRequirement'])
      attrs['Needs Ticket'] = needs_ticket?(attributes) ? 'YES' : ''
    end
  end

  def concession_requirement_field value
    return if value.blank?
    value =~ /NON-refundable fee/ ? 'Fee' : 'Deposit'
  end

  def needs_ticket? attributes
    attributes['Paid'].to_i < attributes['Cost'].to_i ||
    attributes['Notes'] =~ /^NEED/ ||
    attributes['Deposit Check Received'].blank?
  end
end
