class Institution < ApplicationRecord
  belongs_to :city
  has_many :contacts

  validates :name, presence: true
  validates :acronym, presence: true
end
