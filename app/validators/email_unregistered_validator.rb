class EmailUnregisteredValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    contact = Contact.find_by email: value

    if contact && contact.unregistered?
      record.errors[attribute] << "desregistrado";
    end
  end
end