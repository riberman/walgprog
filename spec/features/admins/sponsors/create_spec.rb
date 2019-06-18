require 'rails_helper'

describe 'Admins::Event::Sponsor::create', type: :feature do
  let(:resource_name) { SponsorEvent.model_name.human }
  let(:admin) { create(:admin) }
  let!(:event) { create_list(:event, 3).sample }
  let!(:institution) { create_list(:institution, 3).sample }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_event_sponsors_path(event)
  end

  context 'when data is valid', js: true do
    it 'add sponsor' do
      selectize institution.name, from: 'sponsor_id'
      click_button

      expect(page).to have_current_path admins_event_sponsors_path(event)

      success_message = I18n.t('flash.actions.add.m', resource_name: resource_name)
      expect(page).to have_flash(:success, text: success_message)

      within('table tbody') do
        expect(page).to have_content(institution.id)
        expect(page).to have_content(institution.name)
        expect(page).to have_content(institution.acronym)
      end
    end
  end

  context 'when data are not valid', js: true do
    it 'show errors' do
      click_button

      expect(page).to have_current_path admins_event_sponsors_path(event)
      expect(page).to have_flash(:danger, text: I18n.t('errors.sponsors.none_selected'))
    end
  end
end
