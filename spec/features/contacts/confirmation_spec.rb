require 'rails_helper'

describe 'Contact::confirmation', type: :feature do
  let(:contact) { create(:contact) }

  it 'success' do
    token = contact.generate_confirmation_token
    visit contact_registration_confirmation_path(contact, token)

    expect(page).to have_current_path(contact_feedback_path)
    expect(page).to have_content(I18n.t('contacts.messages.confirmed', name: contact.name))
  end

  it 'invalid token' do
    visit contact_registration_confirmation_path(contact, 'invalid-token')

    expect(page).to have_current_path(contact_feedback_path)
    expect(page).to have_content(I18n.t('contacts.messages.invalid_token'))
  end
end
