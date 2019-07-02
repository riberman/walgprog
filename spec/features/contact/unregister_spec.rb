require 'rails_helper'

describe 'Contact::unregister', type: :feature do
  let(:contact) { create(:contact) }

  it 'success' do
    visit contact_confirm_unregister_path(contact, contact[:unregister_token])
    click_button

    puts contact.reload
    expect(contact.unregistered).to be true
    expect(page).to have_content(I18n.t('feedback.unregistered'))
  end
end
