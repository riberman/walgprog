require 'rails_helper'

describe 'Admins::Events::Breadcrumbs', type: :feature do
  let(:admin) { create(:admin) }
  let(:resource_name) { Event.model_name.human }
  let(:resource_name_plural) { Event.model_name.human count: 2 }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  context 'when index' do
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: text_for_index, path: admins_events_path }
      ]
    end

    it 'show breadcrumbs' do
      visit admins_events_path
      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb', last: :text)
    end
  end

  context 'when create' do
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: text_for_index, path: admins_events_path },
        {text: text_for_new_m, path: new_admins_event_path }
      ]
    end

    before(:each) do
      visit new_admins_event_path
    end

    it 'show breadcrumbs on new' do
      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb', last: :text)
    end

    it 'show breadcrumbs on create' do
      click_button
      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb')
    end
  end

  context 'when edit' do
    let!(:event) { create(:event) }
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: text_for_index, path: admins_events_path },
        { text: text_for_edit, path: edit_admins_event_path(event) }
      ]
    end

    before(:each) do
      visit edit_admins_event_path(event)
    end

    it 'show breadcrumbs on edit' do
      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb', last: :text)
    end

    it 'show breadcrumbs on update' do
      fill_in 'event_name', with: ''
      click_button

      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb')
    end
  end
end
