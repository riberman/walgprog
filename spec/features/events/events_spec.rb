require 'rails_helper'

describe 'Admin:login', type: :feature do
  let(:admin) { create(:admin) }
  let!(:event) { create(:event) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_events_path
  end

  it 'displays the events list' do
    expect(page).to have_content(event.name)
    expect(page).to have_content(I18n.l(event.beginning_date, format: :short))
    expect(page).to have_content(I18n.l(event.end_date, format: :short))
    expect(page).to have_content(event.local)
    expect(page).to have_content(event.city.name)
    expect(page).to have_content(event.address)
  end
end
