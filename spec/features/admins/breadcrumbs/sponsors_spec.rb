require 'rails_helper'

describe 'Admins::Event::Sponsor::Breadcrumbs', type: :feature do
  let(:admin) { create(:admin) }
  let!(:event) { create(:event) }
  let!(:institution) { create(:institution) }
  let(:resource_name) { SponsorEvent.model_name.human }
  let(:resource_name_plural) { Event.model_name.human count: 2 }
  let(:breadcrumbs) do
    [
      { text: text_for_home, path: admins_root_path },
      { text: text_for_index, path: admins_events_path },
      { text: text_for_index }
    ]
  end

  before(:each) do
    login_as(admin, scope: :admin)
  end

  context 'when index' do
    it 'show breadcrumbs' do
      visit admins_event_sponsors_path(event)
      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb', last: :text)
    end
  end

  context 'when create', js: true do
    before(:each) do
      visit admins_event_sponsors_path(event)
    end

    it 'show breadcrumbs on create' do
      selectize institution.name, from: 'sponsor_id'
      click_button

      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb', last: :text)
    end
  end
end
