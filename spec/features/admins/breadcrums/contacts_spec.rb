require 'rails_helper'

describe 'Admins::Contact::Breadcrumbs', type: :feature do
  let(:admin) { create(:admin) }
  let(:resource_name) { Contact.model_name.human }
  let(:resource_name_plural) { Contact.model_name.human count: 2 }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  context 'when index' do
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: text_for_index, path: admins_contacts_path }
      ]
    end

    it 'show breadcrumbs' do
      visit admins_contacts_path
      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb', last: :text)
    end
  end

  context 'when create' do
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: text_for_index, path: admins_contacts_path },
        { text: text_for_new, path: new_admins_contact_path }
      ]
    end

    before(:each) do
      visit new_admins_contact_path
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
        { text: text_for_index, path: admins_contacts_path },
        { text: text_for_edit, path: edit_admins_contact_path(contact) }
      ]
    end

    before(:each) do
      visit edit_admins_contact_path(contact)
    end

    it 'show breadcrumbs on edit' do
      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb', last: :text)
    end

    it 'show breadcrumbs on update' do
      fill_in 'contact_name', with: ''
      click_button

      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb')
    end
  end
end
