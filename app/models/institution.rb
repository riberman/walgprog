class Institution < ApplicationRecord
  belongs_to :city
  has_many :contacts, dependent: :restrict_with_error

  validates :name, presence: true
  validates :acronym, presence: true
end
