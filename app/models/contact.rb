class Contact < ApplicationRecord
  include TokenManager

  register_tokens :update, :unregister

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

  scope :registered,   -> { where(unregistered: false).with_relationships.order(name: :asc) }
  scope :unregistered, -> { where(unregistered: true).with_relationships.order(name: :asc) }
  scope :with_relationships, -> { includes(:institution) }

  def email_with_name
    %("#{name}" <#{email}>)
  end

  def send_welcome_email
    generate_update_token
    generate_unregister_token
    ContactMailer.with(contact: self).welcome.deliver_later
  end

  def send_success_update_email
    ContactMailer.with(contact: self).success_update.deliver_later
  end
end
