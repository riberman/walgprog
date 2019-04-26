class Event < ApplicationRecord
  belongs_to :city, class_name: 'City', foreign_key: :city_id, inverse_of: :events

  validates :name, :city_id, :beginning_date, presence: true
  validates :color, :end_date, :initials, :local, :address, presence: true

  validate :end_greater_then_begin
  validate :valid_year_event, on: :create
  validate :validate_beginning_date, on: :update
  validate :validate_end_date, on: :update

  def full_address
    "#{address} - #{city.name}/#{city.state.acronym}"
  end

  private

  def valid_year_event
    query_beginning = 'extract(year  from beginning_date) = ?'
    query_end = 'extract(year  from end_date) = ?'
    events_beginning = Event.where(query_beginning, beginning_date.try(:year))
    events_end = Event.where(query_end, end_date.try(:year))
    errors.add(:beginning_date, I18n.t('events.error.year_used')) if events_beginning.present?
    errors.add(:end_date, I18n.t('events.error.year_used')) if events_end.present?
  end

  def validate_beginning_date
    query_beginning = 'extract(year  from beginning_date) = ? AND id != ?'

    events = Event.where(query_beginning, beginning_date.year, id)

    errors.add(:beginning_date, I18n.t('events.error.year_used')) if events.present?
  end

  def validate_end_date
    query_end = 'extract(year  from end_date) = ? AND id != ?'
    events = Event.where(query_end, end_date.year, id)
    errors.add(:end_date, I18n.t('events.error.year_used')) if events.present?
  end

  def end_greater_then_begin
    valid_date = beginning_date && end_date && (end_date >= beginning_date)
    errors.add(:end_date, I18n.t('events.invalid_dates')) unless valid_date
  end
end
