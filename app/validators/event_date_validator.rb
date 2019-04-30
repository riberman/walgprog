class EventDateValidator < ActiveModel::Validator
  def validate(event)
    valid_beginning_year_event(event)
    valid_end_year_event(event)
    end_greater_then_begin(event)
  end

  def valid_beginning_year_event(event)
    query_beginning = 'extract(year  from beginning_date) = ?'
    events_beginning = Event.where(query_beginning, event.beginning_date.try(:year))
    event.errors[:beginning_date] << I18n.t('events.error.year_used') if events_beginning.present?
  end

  def valid_end_year_event(event)
    query_end = 'extract(year  from end_date) = ?'
    events_end = Event.where(query_end, event.end_date.try(:year))
    event.errors[:end_date] << I18n.t('events.error.year_used') if events_end.present?
  end

  def end_greater_then_begin(event)
    valid_date = event.beginning_date && event.end_date && (event.end_date >= event.beginning_date)
    event.errors[:end_date] << I18n.t('events.invalid_dates') unless valid_date
  end
end
