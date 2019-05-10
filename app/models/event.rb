class Event < ApplicationRecord
  include ActiveModel::Validations
  include DateFormatter

  belongs_to :city

  validates :name, :city_id, :beginning_date, presence: true
  validates :color, :end_date, :initials, :local, :address, presence: true
  validates_with EventDateValidator, on: :create
  validates_with EventUpdateDateValidator, on: :update

  preload city: :state

  def full_address
    "#{address} - #{city.name}/#{city.state.acronym}"
  end
end
