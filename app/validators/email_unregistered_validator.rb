class EmailUnregisteredValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    contact = Contact.find_by email: value

    record.errors[attribute] << 'desregistrado' if contact&.unregistered?
  end
end
