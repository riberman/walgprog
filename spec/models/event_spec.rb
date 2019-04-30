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
  end
end
