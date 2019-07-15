require 'rails_helper'

RSpec.describe 'Admins::active_link', type: :feature do
  let(:admin) { create(:admin) }
  let(:active_class) { 'list-group-item list-group-item-action active' }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  it 'have a dashboard active' do
    visit admins_root_path
    expect(page).to have_link(I18n.t('helpers.home'), class: active_class)
  end

  context 'when visit contacts' do
    let!(:contact) { create(:contact) }

    it 'index active' do
      visit admins_contacts_path
      expect(page).to have_link(I18n.t('contacts.all'), class: active_class)
    end

    it 'new active' do
      visit new_admins_contact_path
      expect(page).to have_link(I18n.t('contacts.all'), class: active_class)
    end

    it 'edit active' do
      visit edit_admins_contact_path(contact)
      expect(page).to have_link(I18n.t('contacts.all'), class: active_class)
    end

    it 'show active' do
      visit admins_contact_path(contact)
      expect(page).to have_link(I18n.t('contacts.all'), class: active_class)
    end

    it 'show active at unregister' do
      visit admins_contacts_unregistered_path
      expect(page).to have_link(I18n.t('contacts.unregistered'), class: active_class)
    end

    it 'show active at register' do
      visit admins_contacts_registered_path
      expect(page).to have_link(I18n.t('contacts.registered'), class: active_class)
    end
  end

  context 'when visit institutions' do
    let!(:institution) { create(:institution) }

    it 'index active' do
      visit admins_institutions_path
      expect(page).to have_link(I18n.t('institutions.index'), class: active_class)
    end

    it 'new active' do
      visit new_admins_institution_path
      expect(page).to have_link(I18n.t('institutions.index'), class: active_class)
    end

    it 'edit active' do
      visit edit_admins_institution_path(institution)
      expect(page).to have_link(I18n.t('institutions.index'), class: active_class)
    end
  end

  context 'when visit events' do
    let!(:event) { create(:event) }

    it 'index active' do
      visit admins_events_path
      expect(page).to have_link(I18n.t('events.index'), class: active_class)
    end

    it 'new active' do
      visit new_admins_event_path
      expect(page).to have_link(I18n.t('events.index'), class: active_class)
    end

    it 'edit active' do
      visit edit_admins_event_path(event)
      expect(page).to have_link(I18n.t('events.index'), class: active_class)
    end

    it 'show active' do
      visit admins_event_path(event)
      expect(page).to have_link(I18n.t('events.show'), class: active_class)
    end
  end

  context 'when visit sections' do
    let!(:section) { create(:section) }

    it 'index active' do
      visit admins_event_sections_path(section.event)
      expect(page).to have_link(I18n.t('events.sections'), class: active_class)
    end

    it 'new active' do
      visit new_admins_event_section_path(section.event)
      expect(page).to have_link(I18n.t('events.sections'), class: active_class)
    end

    it 'edit active' do
      visit edit_admins_event_section_path(section.event, section)
      expect(page).to have_link(I18n.t('events.sections'), class: active_class)
    end

    it 'show active' do
      visit admins_event_section_path(section.event, section)
      expect(page).to have_link(I18n.t('events.sections'), class: active_class)
    end
  end

  context 'when visit admins' do
    it 'index active' do
      visit admins_admins_path
      expect(page).to have_link(I18n.t('admins.index'), class: active_class)
    end

    it 'new active' do
      visit new_admins_admin_path
      expect(page).to have_link(I18n.t('admins.index'), class: active_class)
    end

    it 'edit active' do
      visit edit_admins_admin_path(admin)
      expect(page).to have_link(I18n.t('admins.index'), class: active_class)
    end
  end

  context 'when visit researchers' do
    let!(:researcher) { create(:researcher) }

    it 'index active' do
      visit admins_researchers_path
      expect(page).to have_link(I18n.t('researchers.index'), class: active_class)
    end

    it 'new active' do
      visit new_admins_researcher_path
      expect(page).to have_link(I18n.t('researchers.index'), class: active_class)
    end

    it 'edit active' do
      visit edit_admins_researcher_path(researcher)
      expect(page).to have_link(I18n.t('researchers.index'), class: active_class)
    end

    it 'show active' do
      visit admins_researcher_path(researcher)
      expect(page).to have_link(I18n.t('researchers.index'), class: active_class)
    end
  end

  context 'when visit sponsors' do
    let!(:event) { create(:event) }

    it 'index active' do
      visit admins_event_sponsors_path(event)
      expect(page).to have_link(I18n.t('sponsors.index'), class: active_class)
    end
  end
end
