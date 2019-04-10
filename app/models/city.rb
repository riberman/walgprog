class City < ApplicationRecord
  has_many :institutions, dependent: :restrict_with_error
  belongs_to :state

  validates :name, presence: true
end
