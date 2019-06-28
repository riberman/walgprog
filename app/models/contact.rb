class Contact < ApplicationRecord
  PHONE_REGEX = /\A\(\d{2}\) \d{4,5}-\d{4}\z/.freeze

  belongs_to :institution

  validates :name, presence: true
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: Devise.email_regexp },
            uniqueness: { case_sensitive: false },
            email_unregistered: true

  validates :phone,
            presence: false,
            length: { minimum: 14, maximum: 15 },
            format: { with: PHONE_REGEX, allow_blank: true }

  def assign_tokens
    generate_token(:unregister_token)
    generate_token(:update_data_token)
    self.update_data_send_at = Time.zone.now
  end

  def generate_token(column)
    self[column] = SecureRandom.urlsafe_base64 while Contact.exists?(column => self[column])
  end

  def update_by_token(params_contact)
    if update(params_contact)
      ContactMailer.with(contacts: self).self_update_contact.deliver
      invalidate_token
      return true
    end
    false
  end

  def update_by_token_to_unregister(params)
    if equal_token(params)
      if Contact.update(params[:id], unregistered: true)
        ContactMailer.with(contacts: self).unregistered_contact.deliver
        return true
      end
    end
    false
  end

  def equal_token(params)
    return true if params[:token].eql? unregister_token

    false
  end

  def valid_token(params)
    final_valid_time = (update_data_send_at + 2.hours)

    return true if (params[:token].eql? update_data_token) && (final_valid_time > Time.zone.now)

    false
  end

  def invalidate_token
    self.update_data_send_at = (update_data_send_at - 2.hours)
  end

  def send_welcome_email
    ContactMailer.with(contacts: self).welcome_email.deliver
  end
end
