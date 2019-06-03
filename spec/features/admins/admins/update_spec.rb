require 'rails_helper'

describe 'Admins::Admin::update', type: :feature do
  let(:resource_name) { Admin.model_name.human }
  let(:admin) { create(:admin) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit edit_admins_admin_path(admin)
  end

  context 'when render edit', js: true do
    it 'filled the fields correctly' do
      expect(page).to have_field('admin_name', with: admin.name)
      expect(page).to have_field('admin_email', with: admin.email)
    end
  end

  context 'whith valid fields', js: true do
    it 'update admin' do
      new_name = 'new admin name'
      new_email = 'new@admin.com'

      fill_in 'admin_name', with: new_name
      fill_in 'admin_email', with: new_email
      click_button

      expect(page).to have_current_path admins_admins_path

      success_message = I18n.t('flash.actions.update.m', resource_name: resource_name)
      expect(page).to have_flash('success', text: success_message)

      within('table tbody') do
        expect(page).to have_content(new_name)
        expect(page).to have_content(new_email)
      end
    end
  end

  context 'whith invalid fields', js: true do
    it 'show errors' do
      fill_in 'admin_name', with: ''
      fill_in 'admin_email', with: ''
      click_button

      expect(page).to have_current_path admins_admin_path(admin)
      expect(page).to have_flash('danger', text: I18n.t('flash.actions.errors'))

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.admin_name')
      expect(page).to have_message(message_blank_error, in: 'div.admin_email')
    end

    it 'change password and password confirmation empty' do
      fill_in 'admin_password', with: '55555'
      click_button

      expect(page).to have_current_path admins_admin_path(admin)
      expect(page).to have_flash('danger', text: I18n.t('flash.actions.errors'))

      message_password_not_equal = 'Confirmação de senha não é igual a Senha'
      div_password_confirmation = 'div.admin_password_confirmation'
      expect(page).to have_message(message_password_not_equal, in: div_password_confirmation)
    end
  end
end
