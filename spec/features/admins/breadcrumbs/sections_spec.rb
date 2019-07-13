require 'rails_helper'

describe 'Admins::Section::Breadcrumbs', type: :feature do
  let(:admin) { create(:admin) }
  let(:section) { create(:section) }
  let(:resource_name) { Section.model_name.human }
  let(:resource_name_plural) { Section.model_name.human count: 2 }
  let(:event_plural_name) { Event.model_name.human count: 2 }
  let(:event_current) { "#{Event.model_name.human} ##{section.event.id}" }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  context 'when index' do
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: event_plural_name, path: admins_events_path },
        { text: event_current, path: admins_event_path(section.event) },
        { text: text_for_index, path: admins_event_sections_path(section.event) }
      ]
    end

    it 'show breadcrumbs' do
      visit admins_event_sections_path(section.event)
      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb', last: :text)
    end
  end

  context 'when create' do
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: event_plural_name, path: admins_events_path },
        { text: event_current, path: admins_event_path(section.event) },
        { text: text_for_new_f, path: new_admins_event_section_path(section.event) }
      ]
    end

    before(:each) do
      visit new_admins_event_section_path(section.event)
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
    let!(:contact) { create(:contact) }
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: event_plural_name, path: admins_events_path },
        { text: event_current, path: admins_event_path(section.event) },
        { text: text_for_edit, path: edit_admins_event_section_path(section.event, section) }
      ]
    end

    before(:each) do
      visit edit_admins_event_section_path(section.event, section)
    end

    it 'show breadcrumbs on edit' do
      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb', last: :text)
    end

    it 'show breadcrumbs on update' do
      fill_in 'section_title', with: ''
      click_button

      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb')
    end
  end
end
