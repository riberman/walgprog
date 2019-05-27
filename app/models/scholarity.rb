class Scholarity < ApplicationRecord
  has_many :researchers, dependent: :destroy

  validates :name, :abbr, presence: true, uniqueness: { case_sensitive: false }
end