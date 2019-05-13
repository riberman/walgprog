class EventUpdateDateValidator < ActiveModel::Validator
  def validate(event)
    validate_beginning_date(event)
    validate_end_date(event)
    end_greater_then_begin(event)
  end

  def validate_beginning_date(event)
    query_beginning = 'extract(year  from beginning_date) = ? AND id != ?'
    events = Event.where(query_beginning, event.beginning_date.try(:year), event.try(:id)).present?
    event.errors[:beginning_date] << I18n.t('events.errors.year_used') if events.present?
  end

  def validate_end_date(event)
    query_end = 'extract(year  from end_date) = ? AND id != ?'
    events = Event.where(query_end, event.end_date.try(:year), event.try(:id))
    event.errors[:end_date] << I18n.t('events.errors.year_used') if events.present?
  end

  def end_greater_then_begin(event)
    valid_date = event.beginning_date && event.end_date && (event.end_date >= event.beginning_date)
    event.errors[:end_date] << I18n.t('events.errors.invalid_dates') unless valid_date
  end
end
