class Institution < ApplicationRecord
  include VirtualState::Model

  belongs_to :city
  has_many :contacts, dependent: :restrict_with_error
  has_many :sponsor_events, dependent: :restrict_with_error
  has_many :events, through: :sponsor_events

  validates :name, presence: true
  validates :acronym, presence: true
  validates :city_id, presence: true
  validates :state_id, presence: true
end
