class Admin < ApplicationRecord
  include Classifiable

  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  mount_uploader :image, ProfileImageUploader

  validates :name, presence: true
  validates :user_type, presence: true

  def update(params)
    if params[:password]&.empty? && params[:password_confirmation]&.empty?
      update_without_password(params)
    end
    super(params)
  end
end
