class Contact < ApplicationRecord
  before_create {generate_token(:unregister_token)}
  PHONE_REGEX = /\A\(\d{2}\) \d{4,5}-\d{4}\z/.freeze

  belongs_to :institution

  validates :name, presence: true
  validates :email,
            presence: true,
            length: {maximum: 255},
            format: {with: Devise.email_regexp},
            uniqueness: {case_sensitive: false}
  validates :phone,
            presence: false,
            length: {minimum: 14, maximum: 15},
            format: {with: PHONE_REGEX, allow_blank: true}

  def send_update_data_token
    generate_token(:update_data_token)
    self.update_data_send_at = Time.zone.now
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Contact.exists?(column => self[column])
  end

  def exists_email(email)
    return Contact.exists?(:email => email)
  end

end
