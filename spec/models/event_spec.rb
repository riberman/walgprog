require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validates' do
    [:name,
     :city_id,
     :beginning_date,
     :end_date,
     :color,
     :initials,
     :local,
     :address].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end

  describe 'custom date validations' do
    it 'not create when beginning_date greater then end_date' do
      event = create(:event)
      event.beginning_date = event.end_date + 10.days

      event.valid?
      event.errors[:end_date].should include(I18n.t('events.invalid_dates'))
    end

    it 'not create when try already used year' do
      first_event = create(:event)
      event = Event.new
      event.beginning_date = first_event.beginning_date
      event.end_date = first_event.end_date
      event.valid?
      event.errors[:end_date].should include(I18n.t('events.error.year_used'))
      event.errors[:beginning_date].should include(I18n.t('events.error.year_used'))
    end

    it 'update without check self year' do
      event = create(:event)
      event.update(beginning_date: Time.now.in_time_zone + 10.minutes)
      expect(event.valid?).to eq(true)
    end
  end
end
