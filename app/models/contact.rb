class Contact < ApplicationRecord
  include TokenManager

  register_tokens :update, :unregister, :confirmation

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

  def confirmed?
    !confirmed_at.nil?
  end

  def confirm
    update(confirmed_at: Time.zone.now)
    invalidate_confirmation_token
  end

  def set_as_unregistered
    update(unregistered: true)
  end

  def set_as_registered
    update(unregistered: false)
  end

  def email_with_name
    %("#{name}" <#{email}>)
  end

  def send_welcome_email
    generate_update_token
    generate_unregister_token
    ContactMailer.with(contact: self).welcome.deliver_later
  end

  def send_update_email
    generate_update_token
    ContactMailer.with(contact: self).update.deliver_later
  end

  def send_updated_email
    ContactMailer.with(contact: self).updated.deliver_later
  end

  def send_confirmation_email
    generate_confirmation_token
    ContactMailer.with(contact: self).confirmation.deliver_later
  end
end
