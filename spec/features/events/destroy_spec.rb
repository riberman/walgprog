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

    success_message = I18n.t('flash.actions.destroy.m', resource_name: Event.model_name.human)
    expect(page).to have_flash(:success, text: success_message)
  end
end
