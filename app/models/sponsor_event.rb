class SponsorEvent < ApplicationRecord
  validates :event, presence: true
  validates :institution, presence: true, uniqueness: {scope: :event}

  belongs_to :event
  belongs_to :institution
end
