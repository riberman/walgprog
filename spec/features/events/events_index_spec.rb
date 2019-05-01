require 'rails_helper'

describe 'Event:index', type: :feature do
  let(:admin) { create(:admin) }
  let!(:event) { create(:event) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_events_path
  end

  it 'displays the events list' do
    expect(page).to have_content(event.name)
    expect(page).to have_content(event.initials)
    expect(page).to have_content(
      I18n.t('events.from_until', beginning: I18n.l(event.beginning_date, format: :short_hour),
                                  end: I18n.l(event.end_date, format: :short_hour)))
    expect(page).to have_content(event.local)
  end
end
