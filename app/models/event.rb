class Event < ApplicationRecord
  include ActiveModel::Validations
  include DateFormatter

  belongs_to :city

  validates :name, :state_id, :city_id, :beginning_date, presence: true
  validates :color, :end_date, :initials, :local, :address, presence: true
  validates_with EventDateValidator, on: :create
  validates_with EventUpdateDateValidator, on: :update

  preload city: :state

  attr_writer :state_id

  def state
    return city.state if city

    State.find_by(id: state_id) if state_id
  end

  def state_id
    return city.state.try(:id) if city

    @state_id
  end

  def full_address
    "#{address} - #{city.name}/#{city.state.acronym}"
  end
end
