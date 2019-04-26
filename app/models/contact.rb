class Contact < ApplicationRecord
  belongs_to :institution

  validates :name, presence: true
  validates :email, presence: true, format: { with: Devise.email_regexp }
  validates :phone, presence: false
end
