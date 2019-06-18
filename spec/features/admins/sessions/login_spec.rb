require 'rails_helper'

describe 'Admins::Session::login', type: :feature do
  let(:admin) { create(:admin) }

  before(:each) do
    visit new_admin_session_path
  end

  it 'displays the admin perfil links on valid login' do
    fill_in 'admin_email', with: admin.email
    fill_in 'admin_password', with: 'password'

    click_button

    expect(page).to have_current_path admins_root_path
    expect(page).to have_selector('div.alert.alert-info',
                                  text: I18n.t('devise.sessions.signed_in'))
  end

  it 'displays the admins error' do
    fill_in 'admin_email', with: admin.email
    fill_in 'admin_password', with: 'passworda'

    click_button

    expect(page).to have_current_path new_admin_session_path

    resource_name = Admin.human_attribute_name(:email)
    expect(page).to have_selector('div.alert.alert-warning',
                                  text: I18n.t('devise.failure.invalid',
                                               authentication_keys: resource_name))
  end

  context 'when user is not authenticated' do
    before(:each) do
      visit admins_root_path
    end

    it 'redirect to login page' do
      expect(page).to have_current_path new_admin_session_path
      expect(page).to have_selector('div.alert.alert-warning',
                                    text: I18n.t('devise.failure.unauthenticated'))
    end
  end
end
