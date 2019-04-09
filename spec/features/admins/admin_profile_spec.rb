require 'rails_helper'

describe 'Admin:Profiles', type: :feature do
  context 'when update my profile' do
    let(:admin) { create(:admin) }

    before(:each) do
      login_as(admin, scope: :admin)
      visit edit_admin_registration_path
    end

    it 'updates with success when the data are valid' do
      new_email = 'email@email.com'
      new_name = 'new name'

      fill_in 'admin_email', with: new_email
      fill_in 'admin_name', with: new_name

      attach_file 'admin_image', FileSpecHelper.image.path
      fill_in 'admin_current_password', with: admin.password

      click_button

      expect(page).to have_current_path edit_admin_registration_path
      expect(page).to have_selector('div.alert.alert-info',
                                    text: I18n.t('devise.registrations.updated'))

      within('a.nav-link') do
        expect(page).to have_content(new_name)
      end

      expect(page).to have_field 'admin_name', with: new_name
      expect(page).to have_field 'admin_email', with: new_email

      admin.reload
      expect(page).to have_css("img[src*='#{admin.image.url}']")
    end

    it 'does not update with invalid date' do
      fill_in 'admin_name', with: ''
      fill_in 'admin_email', with: 'email'
      fill_in 'admin_current_password', with: admin.password
      attach_file 'admin_image', FileSpecHelper.pdf.path

      click_button

      expect(page).to have_selector('div.alert.alert-danger',
                                    text: I18n.t('simple_form.error_notification.default_message'))

      within('div.admin_name') do
        expect(page).to have_content(I18n.t('errors.messages.blank'))
      end
      within('div.admin_email') do
        expect(page).to have_content(I18n.t('errors.messages.invalid'))
      end
      within('div.admin_current_password') do
        key = 'devise.registrations.edit.current_password_to_confirm'
        expect(page).to have_content(I18n.t(key))
      end
      within('div.admin_image') do
        expect(page).to have_content(I18n.t('errors.messages.extension_whitelist_error',
                                            extension: '"pdf"',
                                            allowed_types: 'jpg, jpeg, gif, png'))
      end
    end
  end
end
