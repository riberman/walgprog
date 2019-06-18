require 'rails_helper'

describe 'Admins::Admin::authorization', type: :feature do
  let(:collaborator) { create(:admin, :collaborator) }

  before(:each) do
    login_as(collaborator, scope: :admin)
  end

  context 'when not authorized' do
    it 'to visit new admin path' do
      visit new_admins_admin_path

      expect(page).to have_current_path admins_admins_path
      expect(page).to have_flash(:danger, text: I18n.t('flash.not_authorized'))
    end

    it 'to visit edit admin path' do
      admin = create(:admin)
      visit edit_admins_admin_path(admin)

      expect(page).to have_current_path admins_admins_path
      expect(page).to have_flash(:danger, text: I18n.t('flash.not_authorized'))
    end
  end
end
