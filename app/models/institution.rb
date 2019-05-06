class Institution < ApplicationRecord
  attr_writer :state_id

  belongs_to :city

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
