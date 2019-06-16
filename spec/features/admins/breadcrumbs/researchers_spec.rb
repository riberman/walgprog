require 'rails_helper'

describe 'Admins::Researchers::Breadcrumbs', type: :feature do
  let(:admin) { create(:admin) }
  let(:resource_name) { Researcher.model_name.human }
  let(:resource_name_plural) { Researcher.model_name.human count: 2 }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  context 'when index' do
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: text_for_index, path: admins_researchers_path }
      ]
    end

    it 'show breadcrumbs' do
      visit admins_researchers_path
      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb', last: :text)
    end
  end

  context 'when create' do
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: text_for_index, path: admins_researchers_path },
        { text: text_for_new_m, path: new_admins_researcher_path }
      ]
    end

    before(:each) do
      visit new_admins_researcher_path
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
    let!(:researcher) { create(:researcher) }
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: text_for_index, path: admins_researchers_path },
        { text: text_for_edit, path: edit_admins_researcher_path(researcher) }
      ]
    end

    before(:each) do
      visit edit_admins_researcher_path(researcher)
    end

    it 'show breadcrumbs on edit' do
      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb', last: :text)
    end

    it 'show breadcrumbs on update' do
      fill_in 'researcher_name', with: ''
      click_button

      expect(page).to have_breadcrumbs(breadcrumbs, in: 'ol.breadcrumb')
    end
  end
end
