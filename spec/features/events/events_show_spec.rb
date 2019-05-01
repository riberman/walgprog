require 'rails_helper'

describe 'Event:show', type: :feature do
  let(:admin) { create(:admin) }
  let(:event) { create(:event) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_event_path(event.id)
  end

  it 'shows the event' do
    expect(page).to have_content(event.name)
    expect(page).to have_content(I18n.l(event.beginning_date, format: :default))
    expect(page).to have_content(I18n.l(event.end_date, format: :default))
    expect(page).to have_content(event.local)
    expect(page).to have_content(event.city.name)
    expect(page).to have_content(event.address)
  end
end
