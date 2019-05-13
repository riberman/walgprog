require 'rails_helper'

describe 'Admins:logout', type: :feature do
  let(:admin) { create(:admin) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_root_path
  end

  it 'displays success logout message' do
    click_link admin.name
    click_link(I18n.t('sessions.sign_out'))

    expect(page).to have_current_path new_admin_session_path

    expect(page).to have_selector('div.alert.alert-info',
                                  text: I18n.t('devise.sessions.already_signed_out'))
  end
end
