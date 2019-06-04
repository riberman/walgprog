require 'rails_helper'

describe 'Admins::Event::add_sponsor', type: :feature do
  let(:resource_name) { Event.model_name.human }
  let(:admin) { create(:admin) }
  let!(:city) { create(:city) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_event_sponsors_path
  end

  context 'with links' do
    it { expect(page).to have_link(I18n.t('sponsors.index'), href: admins_event_sponsors) }

    #expect(page).to have_link(href: admins_event_sponsors)
  end

  it 'when have sponsor to add' do
    #  expect(event).not_to be_valid
    #  expect(event.errors[:end_date]).to include(I18n.t('events.errors.invalid_dates'))
  end

  it 'when have no sponsor' do

  end
end
