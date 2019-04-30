class Event < ApplicationRecord
  include ActiveModel::Validations
  belongs_to :city, class_name: 'City', foreign_key: :city_id, inverse_of: :events

  validates :name, :city_id, :beginning_date, presence: true
  validates :color, :end_date, :initials, :local, :address, presence: true
  validates_with EventDateValidator, on: :create
  validates_with EventUpdateDateValidator, on: :update

  def full_address
    "#{address} - #{city.name}/#{city.state.acronym}"
  end
end
