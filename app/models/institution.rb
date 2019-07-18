class Institution < ApplicationRecord
  include VirtualState::Model

  belongs_to :city
  has_many :contacts, dependent: :restrict_with_error
  has_many :sponsor_events, dependent: :restrict_with_error
  has_many :events, through: :sponsor_events

  enum approved: { yes: true, not: false }, _suffix: :approved

  def self.human_approveds
    hash = {}
    approveds.each_key { |key| hash[I18n.t("enums.approved.#{key}")] = key }
    hash
  end

  validates :name, presence: true
  validates :acronym, presence: true
  validates :city_id, presence: true
  validates :state_id, presence: true
  validates :approved, presence: true

  scope :approved, -> { where(approved: true).includes(city: [:state]).order(name: :asc) }
  scope :not_approved, -> { where(approved: false).includes(city: [:state]).order(name: :asc) }
end
