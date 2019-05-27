class Researcher < ApplicationRecord
  mount_uploader :image, ProfileImageUploader

  belongs_to :institution
  belongs_to :scholarity

  validates :name, presence: true
  validates :scholarity, presence: true
  validates :institution, presence: true
  validates :genre, presence: true
  # validates :image, presence: true
end
