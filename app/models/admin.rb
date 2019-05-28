class Admin < ApplicationRecord
  include ProfileImage

  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
end
