class State < ApplicationRecord
  belongs_to :region
  has_many :cities, dependent: :destroy
  has_many :events, through: :cities
  validates :acronym, :name, presence: true, uniqueness: { case_sensitive: false }
end
