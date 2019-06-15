require 'rails_helper'
describe 'Admins::Admins::create', type: :feature do
  let(:resource_name) { Admin.model_name.human }
  let(:admin) { create(:admin, :administrator) }

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

    it 'to email' do
      fill_in 'admin_email', with: 'email'
      click_button

      expect(page).to have_message(I18n.t('errors.messages.invalid'), in: 'div.admin_email')
    end

    it 'to password' do
      fill_in 'admin_password', with: '123'
      fill_in 'admin_password_confirmation', with: '1234'
      click_button

      too_short_message = I18n.t('errors.messages.too_short', count: 6)
      expect(page).to have_message(too_short_message, in: 'div.admin_password')

      confirmation_message = I18n.t('errors.messages.confirmation',
                                    attribute: Admin.human_attribute_name(:password))
      expect(page).to have_message(confirmation_message, in: 'div.admin_password_confirmation')
    end
  end

  context 'with valid fields', js: true do
    it 'create admin' do
      attributes = attributes_for(:admin)
      administrator = Admin.human_user_types.keys.first
      action_name = 'flash.actions.create.m'

      fill_in 'admin_name', with: attributes[:name]
      fill_in 'admin_email', with: attributes[:email]
      fill_in 'admin_password', with: attributes[:password]
      fill_in 'admin_password_confirmation', with: attributes[:password_confirmation]
      selectize administrator, from: 'admin_user_type', normalize_id: false
      click_button

      expect(page).to have_current_path admins_admins_path
      expect(page).to have_flash(:success, text: I18n.t(action_name, resource_name: resource_name))

      within('table tbody') do
        expect(page).to have_content(attributes[:name])
        expect(page).to have_content(attributes[:email])
        expect(page).to have_content(administrator)
      end
    end
  end
end
