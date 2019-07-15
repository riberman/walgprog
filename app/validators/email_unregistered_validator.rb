class EmailUnregisteredValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    contact = Contact.where.not(id: record.id).find_by email: value

    record.errors[attribute] << I18n.t('errors.contacts.unregistered') if contact&.unregistered?
  end
end
