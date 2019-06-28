require 'rails_helper'

describe 'Admins::Admin::update', type: :feature do
  let(:resource_name) { Admin.model_name.human }
  let(:administrator) { create(:admin, :administrator) }
  let(:admin) { create(:admin) }

  before(:each) do
    login_as(administrator, scope: :admin)
    visit edit_admins_admin_path(admin)
  end

  context 'when render edit', js: true do
    it 'filled the fields correctly' do
      collaborator = Admin.human_user_types.keys.second

      expect(page).to have_field('admin_name', with: admin.name)
      expect(page).to have_field('admin_email', with: admin.email)
      expect(page).to have_selectize('admin_user_type', selected: collaborator)
      expect(page).to have_field('admin_password', with: '')
      expect(page).to have_field('admin_password_confirmation', with: '')
    end
  end

  context 'with valid fields', js: true do
    it 'update admin' do
      new_name = 'new admin name'
      new_email = 'new@admin.com'
      administrator = Admin.human_user_types.keys.first

      fill_in 'admin_name', with: new_name
      fill_in 'admin_email', with: new_email
      selectize administrator, from: 'admin_user_type', normalize_id: false
      click_button

      expect(page).to have_current_path admins_admins_path

      success_message = I18n.t('flash.actions.update.m', resource_name: resource_name)
      expect(page).to have_flash('success', text: success_message)

      within('table tbody') do
        expect(page).to have_content(new_name)
        expect(page).to have_content(new_email)
        expect(page).to have_content(administrator)
      end
    end

    it 'update admin password' do
      password = '123456'
      fill_in 'admin_password', with: password
      fill_in 'admin_password_confirmation', with: password
      click_button

      logout(:admin)

      visit new_admin_session_path

      fill_in 'admin_email', with: admin.email
      fill_in 'admin_password', with: password
      click_button

      expect(page).to have_current_path admins_root_path
      expect(page).to have_selector('div.alert.alert-info',
                                    text: I18n.t('devise.sessions.signed_in'))
    end
  end

  context 'with invalid fields', js: true do
    it 'show errors' do
      fill_in 'admin_name', with: ''
      fill_in 'admin_email', with: ''
      selectize '', from: 'admin_user_type', normalize_id: false
      click_button

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.admin_name')
      expect(page).to have_message(message_blank_error, in: 'div.admin_email')
      expect(page).to have_message(message_blank_error, in: 'div.admin_user_type')

      expect(page).to have_current_path "/admins/admins/#{admin.id}"
      expect(page).to have_flash('danger', text: I18n.t('flash.actions.errors'))
    end

    it 'for password' do
      fill_in 'admin_password', with: '55555'
      click_button

      confirmation_message = I18n.t('errors.messages.confirmation',
                                    attribute: Admin.human_attribute_name(:password))
      expect(page).to have_message(confirmation_message, in: 'div.admin_password_confirmation')
    end
  end
end
