class Institution < ApplicationRecord
  belongs_to :city

  validates :name, presence: true
  validates :acronym, presence: true
  validates :city_id, presence: true

  def state_id
    state.try(:id)
  end

  def state
    city.try(:state)
  end
end
