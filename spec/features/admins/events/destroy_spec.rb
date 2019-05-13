require 'rails_helper'

describe 'Admins::Event::destroy', type: :feature do
  let(:admin) { create(:admin) }
  let!(:event) { create_list(:event, 3).sample }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_events_path
  end

  it 'delete the event', js: true do
    click_on_destroy_link(admins_event_path(event), alert: true)

    expect(page).to have_current_path admins_events_path
    success_message = I18n.t('flash.actions.destroy.m', resource_name: Event.model_name.human)
    expect(page).to have_flash(:success, text: success_message)

    within('table tbody') do
      expect(page).not_to have_content(event.name)
    end
  end
end
