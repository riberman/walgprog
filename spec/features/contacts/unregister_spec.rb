require 'rails_helper'

describe 'Contact::unregister', type: :feature do
  let(:contact) { create(:contact) }

  it 'success' do
    token = contact.generate_unregister_token
    visit contact_unregister_confirmation_path(contact, token)
    click_button

    expect(page).to have_current_path(contact_feedback_path)
    expect(page).to have_content(I18n.t('contacts.messages.success_unregister', name: contact.name))
  end

  it 'invalid token' do
    token = contact.generate_unregister_token
    visit contact_unregister_confirmation_path(contact, token)
    click_button

    visit contact_unregister_confirmation_path(contact, token)
    click_button

    expect(page).to have_current_path(contact_feedback_path)
    expect(page).to have_content(I18n.t('contacts.messages.invalid_token'))
  end
end
