require 'rails_helper'

describe 'Admins::Profile::Breadcrumbs', type: :feature do
  let(:admin) { create(:admin) }
  let(:resource_name) { Admin.model_name.human }
  let(:resource_name_plural) { Admin.model_name.human count: 2 }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  context 'when edit' do
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: text_for_edit, path: edit_admin_registration_path }
      ]
    end

    before(:each) do
      visit edit_admin_registration_path
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
