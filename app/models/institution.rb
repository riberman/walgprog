class Institution < ApplicationRecord
  include VirtualState::Model

  attr_writer :state_id

  belongs_to :city
  has_many :contacts, dependent: :restrict_with_error

  validates :name, presence: true
  validates :acronym, presence: true
  validates :city_id, presence: true
  validates :state_id, presence: true
end
