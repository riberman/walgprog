class Institution < ApplicationRecord
  attr_writer :state_id

  belongs_to :city
  has_many :contacts, dependent: :restrict_with_error
  has_many :sponsor_events, dependent: :restrict_with_error
  has_many :events, through: :sponsor_events

  validates :name, presence: true
  validates :acronym, presence: true
  validates :city_id, presence: true
  validates :state_id, presence: true

  def state
    return city.state if city

    State.find_by(id: state_id) if state_id
  end

  def state_id
    return city.state.try(:id) if city

    @state_id
  end
end
