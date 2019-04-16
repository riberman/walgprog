class State < ApplicationRecord
  belongs_to :region
  has_many :cities, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :acronym, :name, presence: true, uniqueness: { case_sensitive: false }
end
