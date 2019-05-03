require 'rails_helper'

describe 'Event:update', type: :feature do
  let(:admin) { create(:admin) }
  let!(:event) { create(:event) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit edit_admins_event_path(event)
  end

  after(:each) do
    Event.delete_all
  end

  context 'when event is updated', js: true do
    it 'update event' do
      new_name = 'Teste'
      fill_in 'event_name', with: new_name

      page.execute_script 'window.scrollBy(0,10000)'

      find('input[name="commit"]').click

      expect(page).to have_current_path admins_events_path

      success_message = I18n.t('flash.actions.update.m', resource_name: new_name)
      expect(page).to have_flash(:success, text: success_message)
      expect(page).to have_content(new_name)
    end
  end

  context 'when event is not updated', js: true do
    it 'show errors' do
      fill_in 'event_name', with: ''

      page.execute_script 'window.scrollBy(0,10000)'

      find('input[name="commit"]').click

      expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.event_name')
    end
  end
end
