class Contact < ApplicationRecord
  belongs_to :institution

  validates :name, presence: true
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: Devise.email_regexp },
            uniqueness: { case_sensitive: false }
  validates :phone,
            presence: false,
            length: { minimum: 14, maximum: 15 },
            format: { with: /\A\(\d{2}\) \d{4,5}-\d{4}\z/, allow_blank: true }
end
