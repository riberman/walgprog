require 'rails_helper'

describe 'Event:destroy', type: :feature do
  let(:admin) { create(:admin) }
  let!(:event) { create(:event) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_events_path(event)
  end

  it 'delete the event', js: true do
    attributes = attributes_for(:event)
    first('.destroy').click

    alert = page.driver.browser.switch_to.alert
    alert.accept
    sleep 2.seconds

    success_message = I18n.t('flash.actions.destroy.m', resource_name: attributes[:event])
    expect(page).to have_flash(:success, text: success_message)
  end
end
