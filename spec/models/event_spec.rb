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

    context 'when dates are invalid' do
      let(:event) { create(:event) }

      it 'not create when beginning_date greater then end_date' do
        event.beginning_date = event.end_date + 10.days

        expect(event).not_to be_valid
        expect(event.errors[:end_date]).to include(I18n.t('events.errors.invalid_dates'))
      end

      it 'not create two events in same year' do
        e = Event.new
        e.beginning_date = event.beginning_date
        e.end_date = event.end_date

        expect(e).not_to be_valid
        expect(e.errors[:end_date]).to include(I18n.t('events.errors.year_used'))
        expect(e.errors[:beginning_date]).to include(I18n.t('events.errors.year_used'))
      end

      it 'update without check self year' do
        event.update(beginning_date: Time.now.in_time_zone + 10.minutes)

        expect(event).to be_valid
      end
    end
  end

  context 'with dates valids' do
    let(:event) { build(:event, city: create(:city)) }

    it 'be valid' do
      expect(event).to be_valid
    end

    it 'return date formatted' do
      expect(event.beginning_date.formatted).to eq(I18n.l(event.beginning_date, format: :short))
      expect(event.end_date.formatted).to eq(I18n.l(event.end_date, format: :short))
    end

    it 'create organization section' do
      event.save
      expect(event.sections.count).to eq(1)
    end
  end

  describe '#full_address' do
    let(:event) { build(:event, city: create(:city)) }

    it 'retun address, city and state acronym' do
      full_address = "#{event.address} - #{event.city.name}/#{event.city.state.acronym}"
      expect(event.full_address).to eq(full_address)
    end
  end

  describe '.current_color' do
    it 'return color of current year event' do
      event = create(:event, beginning_date: Time.zone.now,
                             end_date: Time.zone.now + 10.days)
      expect(Event.current_color).to eql(event.color)
    end

    it 'return default color when there is no event' do
      expect(Event.current_color).to eql('#000')
    end

    it 'return default color when have no event in current year' do
      create(:event, beginning_date: Time.zone.now + 1.year,
                     end_date: Time.zone.now + 1.year + 10.days)
      expect(Event.current_color).to eql('#000')
    end
  end
end
