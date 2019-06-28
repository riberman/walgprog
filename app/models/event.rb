class Event < ApplicationRecord
  include ActiveModel::Validations
  include DateFormatter
  include VirtualState::Model

  after_create :create_organization_section

  belongs_to :city
  has_many :sponsor_events, dependent: :restrict_with_error
  has_many :sponsors, through: :sponsor_events, source: :institution

  has_many :sections, dependent: :delete_all

  validates :name, :state_id, :city_id, :beginning_date, presence: true
  validates :color, :end_date, :initials, :local, :address, presence: true
  validates_with EventDateValidator, on: :create
  validates_with EventUpdateDateValidator, on: :update

  def full_address
    "#{address} - #{city.name}/#{city.state.acronym}"
  end

  def self.current_color
    date = Time.now.utc
    e = find_by(['beginning_date >= :beginning_year and end_date <= :end_year',
                 { beginning_year: date.beginning_of_year, end_year: date.end_of_year }])

    return e.color if e

    '#000'
  end

  def sections_to_sort?
    sections.length > 1
  end

  def create_organization_section
    sections.new(title: I18n.t('events.default_section'),
                 status: 'A',
                 can_be_deleted: false,
                 content_markdown: I18n.t('events.default_section_content'),
                 icon: 'star',
                 index: 1)
  end
end
