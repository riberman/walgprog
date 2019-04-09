class Admin < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  mount_uploader :image, ProfileImageUploader
end
