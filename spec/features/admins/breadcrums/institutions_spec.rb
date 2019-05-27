require 'rails_helper'

describe 'Admins::Institutions::Breadcrumbs', type: :feature do
  let(:admin) { create(:admin) }
  let(:resource_name) { Institution.model_name.human }
  let(:resource_name_plural) { Institution.model_name.human count: 2 }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  context 'when index' do
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: text_for_index, path: admins_institutions_path }
      ]
    end

    it 'show breadcrumbs' do
      visit admins_institutions_path
      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb', last: :text)
    end
  end

  context 'when create' do
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: text_for_index, path: admins_institutions_path },
        {text: text_for_new_f, path: new_admins_institution_path }
      ]
    end

    before(:each) do
      visit new_admins_institution_path
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
    let!(:institution) { create(:institution) }
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: text_for_index, path: admins_institutions_path },
        { text: text_for_edit, path: edit_admins_institution_path(event) }
      ]
    end

    before(:each) do
      visit edit_admins_institution_path(institution)
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
