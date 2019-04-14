class Event < ApplicationRecord
  belongs_to :city, class_name: 'City', foreign_key: :city_id

  validates :name, :city_id, :beginning_date, :color, :end_date, :initials, :local, :address, presence: true

  def full_address
    "#{address} - #{city.name}/#{city.state.acronym}"
  end
end
