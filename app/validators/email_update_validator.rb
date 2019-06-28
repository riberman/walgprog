class EmailUpdateValidator < ActiveModel::Validator
  def validate(params, contact)
    contact.errors[:invalid_token] << 'Token Expirado' unless contact.valid_token(params)
  end
end
