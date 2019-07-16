require 'rails_helper'

describe 'Contact::create', type: :feature do
  let!(:institution) { create_list(:institution, 2).sample }
  let(:contact) { create(:contact) }

  before(:each) do
    visit contacts_path
  end

  context 'with valid fields', js: true do
    it 'create a contact' do
      attributes = attributes_for(:contact)

      fill_in 'contact_name', with: attributes[:name]
      fill_in 'contact_email', with: attributes[:email]
      fill_in 'contact_phone', with: attributes[:phone]
      selectize institution.name, from: 'contact_institution'
      expect { click_button }.to change { ActionMailer::Base.deliveries.count }.by(1)

      expect(page).to have_current_path contact_feedback_path
      expect(page).to have_flash(:success, text: I18n.t('contacts.messages.created',
                                                        name: attributes[:name]))
    end
  end

  context 'with unregister email' do
    it 'send email to update' do
      contact.set_as_unregistered
      fill_in 'contact_email', with: contact.email
      expect { click_button }.to change { ActionMailer::Base.deliveries.count }.by(1)

      expect(page).to have_current_path contact_feedback_path
      expect(page).to have_flash(:success, text: I18n.t('contacts.messages.unregistered_create',
                                                        name: contact.name))
    end
  end

  context 'without confirmation' do
    it 'resend email to confirmation' do
      contact.update(confirmed_at: nil)
      fill_in 'contact_email', with: contact.email
      expect { click_button }.to change { ActionMailer::Base.deliveries.count }.by(1)

      expect(page).to have_current_path contact_feedback_path
      expect(page).to have_flash(:info, text: I18n.t('contacts.messages.not_confirmed',
                                                     name: contact.name))
    end
  end

  context 'with fields' do
    it 'filled blank show errors' do
      click_button

      expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.contact_name')
      expect(page).to have_message(message_blank_error, in: 'div.contact_email')

      expect(page).to have_message(I18n.t('errors.messages.too_short',
                                          count: 14), in: 'div.contact_phone')
      expect(page).to have_message(I18n.t('errors.messages.required'),
                                   in: 'div.contact_institution')
    end
  end
end
