require 'rails_helper'

describe 'Admins::Event::create', type: :feature do
  let(:resource_name) { Event.model_name.human }
  let(:admin) { create(:admin) }
  let!(:state) { create_list(:state, 2) }
  let!(:city) do
    create_list(:city, 2, state: State.first)
    create_list(:city, 2, state: State.last)
    City.all.sample
  end

  before(:each) do
    login_as(admin, scope: :admin)
    visit new_admins_event_path
  end

  context 'when data is valid', js: true do
    it 'create event' do
      attributes = attributes_for(:event)

      fill_in 'event_name', with: attributes[:name]
      fill_in 'event_initials', with: attributes[:initials]
      fill_in 'event_color', with: attributes[:color]
      fill_in 'event_local', with: attributes[:local]
      fill_in 'event_address', with: attributes[:address]
      selectize(city.state.name, from: 'event_state_id')
      selectize(city.name, from: 'event_city_id')
      fill_in 'event_beginning_date', with: I18n.l(attributes[:beginning_date], format: :short)
      fill_in 'event_end_date', with: I18n.l(attributes[:end_date], format: :short)
      click_button

      expect(page).to have_current_path admins_events_path

      success_message = I18n.t('flash.actions.create.m', resource_name: resource_name)
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

  context 'when data are not valid' do
    it 'show errors' do
      click_button

      expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.event_name')
      expect(page).to have_message(message_blank_error, in: 'div.event_initials')
      expect(page).to have_message(message_blank_error, in: 'div.event_color')

      expect(page).to have_message(message_blank_error, in: 'div.event_beginning_date')
      expect(page).to have_message(message_blank_error, in: 'div.event_end_date')
      expect(page).to have_message(I18n.t('events.errors.invalid_dates'), in: 'div.event_end_date')

      expect(page).to have_message(message_blank_error, in: 'div.event_state_id')
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

    it 'when has a state selected', js: true do
      selectize(city.state.name, from: 'event_state_id')
      click_button

      expect(page).to have_selectize('event_state_id', selected: city.state.name)
    end

    it 'when has a state and city selected', js: true do
      selectize(city.state.name, from: 'event_state_id')
      selectize(city.name, from: 'event_city_id')
      click_button

      expect(page).to have_selectize('event_state_id', selected: city.state.name)
      expect(page).to have_selectize('event_city_id', selected: city.name)
    end
  end
end
