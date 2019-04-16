class Contact < ApplicationRecord
  belongs_to :institution

  validates :name, presence: true
  validates :email, presence: true
end