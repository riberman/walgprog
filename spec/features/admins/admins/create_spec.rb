require 'rails_helper'
describe 'Admins::Admins::create', type: :feature do
  let(:resource_name) { Admin.model_name.human }
  let(:admin) { create(:admin) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit new_admins_admin_path
  end

  context 'with invalid fields' do
    it 'show errors' do
      click_button

      message_blank_error = I18n.t('errors.messages.blank')

      expect(page).to have_message(message_blank_error, in: 'div.admin_name')
      expect(page).to have_message(message_blank_error, in: 'div.admin_email')
      expect(page).to have_message(message_blank_error, in: 'div.admin_password')
      expect(page).to have_message(message_blank_error, in: 'div.admin_user_type')

      expect(page).to have_current_path admins_admins_path
      expect(page).to have_flash('danger', text: I18n.t('flash.actions.errors'))
    end
  end

  context 'with insert value in fields' do
    it 'create admin' do
      attributes = attributes_for(:admin)

      fill_in 'admin_name', with: attributes[:name]
      fill_in 'admin_email', with: attributes[:email]
      fill_in 'admin_password', with: attributes[:password]
      fill_in 'admin_password_confirmation', with: attributes[:password_confirmation]
      click_button

      message_blank_error = I18n.t('errors.messages.blank')

      expect(page).to have_message(message_blank_error, in: 'div.admin_user_type')
      expect(page).to have_current_path admins_admins_path
      expect(page).to have_flash('danger', text: I18n.t('flash.actions.errors'))
    end
  end
end
