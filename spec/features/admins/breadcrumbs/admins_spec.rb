require 'rails_helper'

describe 'Admins::Institutions::Breadcrumbs', type: :feature do
  let(:administrator) { create(:admin, :administrator) }
  let(:resource_name) { Admin.model_name.human }
  let(:resource_name_plural) { Admin.model_name.human count: 2 }

  before(:each) do
    login_as(administrator, scope: :admin)
  end

  context 'when index' do
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: text_for_index, path: admins_admins_path }
      ]
    end

    it 'show breadcrumbs' do
      visit admins_admins_path
      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb', last: :text)
    end
  end

  context 'when create' do
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: text_for_index, path: admins_admins_path },
        { text: text_for_new_m, path: new_admins_admin_path }
      ]
    end

    before(:each) do
      visit new_admins_admin_path
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
    let!(:admin) { create(:admin) }
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: text_for_index, path: admins_admins_path },
        { text: text_for_edit, path: edit_admins_admin_path(admin) }
      ]
    end

    before(:each) do
      visit edit_admins_admin_path(admin)
    end

    it 'show breadcrumbs on edit' do
      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb', last: :text)
    end

    it 'show breadcrumbs on update' do
      fill_in 'admin_name', with: ''
      click_button

      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb')
    end
  end
end
