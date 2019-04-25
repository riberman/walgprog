require 'rails_helper'

describe 'Event:destroy', type: :feature do
  let(:admin) { create(:admin) }
  let!(:event) { create(:event) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_events_path
  end

  it 'delete the event', js: true do
    first('.destroy').click

    alert = page.driver.browser.switch_to.alert
    alert.accept
    sleep 2.seconds

    success_message = I18n.t('events.success.destroy')
    expect(page).to have_flash(:success, text: success_message)

    expect(page).not_to have_content(event.name)
  end
end
