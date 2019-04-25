require 'rails_helper'

describe 'Event:create', type: :feature do
  let(:admin) { create(:admin) }
  let!(:event) { create(:event) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit new_admins_event_path
  end

  it 'create event', js: true do

    attributes = attributes_for(:event)
    fill_in 'event_name',   with: attributes[:name]
    fill_in 'event_initials',   with: attributes[:initials]
    fill_in 'event_color',   with: attributes[:color]
    fill_in 'event_local',   with: attributes[:local]
    fill_in 'event_address',   with: attributes[:address]


    find('input[name="commit"]').click

    expect(page).to have_current_path admins_events_path

    success_message = I18n.t('events.success.new')

    expect(page).to have_flash(:success, text: success_message)

    expect(page).to have_message(attributes[:name], in: 'table tbody')

  end
end
