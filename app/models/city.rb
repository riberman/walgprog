class City < ApplicationRecord
  default_scope { order(:name, 'name DESC') }

  has_many :institutions, dependent: :restrict_with_error
  has_many :events, dependent: :restrict_with_error
  belongs_to :state

  validates :name, presence: true
end
