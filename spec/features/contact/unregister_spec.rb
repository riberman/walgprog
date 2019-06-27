require 'rails_helper'

describe 'Contact::unregister', type: :feature do
  let(:contact) { create(:contact) }

  it 'success', js: true do
    puts contact
    puts contact[:unregistered]

    visit contact_confirm_unregister_path(contact, contact[:unregister_token])
    click_button
    contact[:unregistered]

    puts contact[:unregistered]
    expect(contact['unregistered']).to have_content(true)
    expect(page).to have_content(I18n.t('feedback.unregistered'))
  end
end
