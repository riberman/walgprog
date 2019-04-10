class Institution < ApplicationRecord
  belongs_to :city

  validates :name, presence: true
  validates :acronym, presence: true
end
