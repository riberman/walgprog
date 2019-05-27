require 'active_support/concern'

module ProfileImage
  extend ActiveSupport::Concern

  included do
    mount_uploader :image, ProfileImageUploader
  end
end
