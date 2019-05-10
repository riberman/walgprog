require 'rails_helper'

describe 'Admins::Event::update', type: :feature do
  let(:resource_name) { Event.model_name.human }
  let(:admin) { create(:admin) }
  let(:event) { create(:event) }
  let!(:city) { create(:city) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit edit_admins_event_path(event)
  end

  context 'when render edit', js: true do
    it 'filled the fields correctly' do
      expect(page).to have_field('event_name', with: event.name)
      expect(page).to have_field('event_initials', with: event.initials)
      expect(page).to have_field('event_color', with: event.color)

      expect(page).to have_field('event_beginning_date', with: event.beginning_date.formatted)
      expect(page).to have_field('event_end_date', with: event.end_date.formatted)

      expect(page).to have_selectize('event_city_id', selected: event.city.name)
      expect(page).to have_field('event_local', with: event.local)
      expect(page).to have_field('event_address', with: event.address)
    end
  end

  context 'when data is valid', js: true do
    it 'update event' do
      attributes = attributes_for(:event, color: '#FFF', initials: 'NEW',
                                          local: 'New Local', address: 'New Address')

      fill_in 'event_name', with: attributes[:name]
      fill_in 'event_initials', with: attributes[:initials]
      fill_in 'event_color', with: attributes[:color]
      fill_in 'event_local', with: attributes[:local]
      fill_in 'event_address', with: attributes[:address]
      fill_in 'event_beginning_date', with: I18n.l(attributes[:beginning_date], format: :short)
      fill_in 'event_end_date', with: I18n.l(attributes[:end_date], format: :short)
      selectize city.name, from: 'event_city_id'
      click_button

      expect(page).to have_current_path admins_events_path

      success_message = I18n.t('flash.actions.update.m', resource_name: resource_name)
      expect(page).to have_flash(:success, text: success_message)

      within('table tbody') do
        expect(page).to have_content(attributes[:name])
        expect(page).to have_content(attributes[:initials])
        expect(page).to have_content(attributes[:local])
        expect(page).to have_content(attributes[:event_beginning_date])
        expect(page).to have_content(attributes[:event_end_date])
        expect(page).to have_content(I18n.l(Event.last.created_at, format: :short_hour))
      end
    end
  end

  context 'when data are not valid', js: true do
    it 'show errors' do
      fill_in 'event_name', with: ''
      fill_in 'event_initials', with: ''
      fill_in 'event_color', with: ''
      fill_in 'event_local', with: ''
      fill_in 'event_address', with: ''
      fill_in 'event_beginning_date', with: ''
      fill_in 'event_end_date', with: ''
      selectize '', from: 'event_city_id'
      click_button

      expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.event_name')
      expect(page).to have_message(message_blank_error, in: 'div.event_initials')
      expect(page).to have_message(message_blank_error, in: 'div.event_color')

      expect(page).to have_message(message_blank_error, in: 'div.event_beginning_date')
      expect(page).to have_message(message_blank_error, in: 'div.event_end_date')
      expect(page).to have_message(I18n.t('events.errors.invalid_dates'), in: 'div.event_end_date')

      expect(page).to have_message(message_blank_error, in: 'div.event_city_id')
      expect(page).to have_message(message_blank_error, in: 'div.event_local')
      expect(page).to have_message(message_blank_error, in: 'div.event_address')
    end

    it 'not register a event in same year' do
      event = create(:event)

      fill_in 'event_beginning_date', with: I18n.l(event.beginning_date, format: :short)
      fill_in 'event_end_date', with: I18n.l(event.end_date, format: :short)
      click_button

      message = I18n.t('events.errors.year_used')
      expect(page).to have_message(message, in: 'div.event_beginning_date')
      expect(page).to have_message(message, in: 'div.event_end_date')
    end
  end
end
