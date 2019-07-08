require 'rails_helper'

describe 'Contact::update', type: :feature do
  let!(:institution) { create_list(:institution, 2).sample }
  let(:contact) { create(:contact) }
  let(:contact_with_invalid_token) do
    create(:contact, update_data_send_at: (Time.zone.now - 6.hours))
  end

  before(:each) do
    visit contact_edit_path(contact, contact.update_data_token)
  end

  context 'when render edit', js: true do
    it 'fields should be filled' do
      expect(page).to have_field('contact_name', with: contact.name)
      expect(page).to have_field('contact_email', with: contact.email)
      expect(page).to have_field('contact_phone', with: contact.phone)
      expect(page).to have_selectize('contact_institution', selected: contact.institution.name)
    end
  end

  context 'with valid fields', js: true do
    it 'update contact' do
      local_name = 'Novo Nome'
      local_email = 'novo@mail.com'
      local_phone = '(42) 99955-3214'

      fill_in 'contact_name', with: local_name
      fill_in 'contact_email', with: local_email
      fill_in 'contact_phone', with: local_phone
      selectize institution.name, from: 'contact_institution'

      click_button

      expect(page).to have_current_path contact_updated_path
    end
  end

  context 'with invalids fields', js: true do
    it 'show errors when fields are blank' do
      fill_in 'contact_name', with: ''
      fill_in 'contact_email', with: ''
      fill_in 'contact_phone', with: ''
      selectize '', from: 'contact_institution'
      click_button

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.contact_name')
      expect(page).to have_message(message_blank_error, in: 'div.contact_email')
      expect(page).to have_message(I18n.t('errors.messages.too_short',
                                          count: 14), in: 'div.contact_phone')
    end

    it 'show errros when phone and email are invalid' do
      fill_in 'contact_email', with: 'email'
      fill_in 'contact_phone', with: '131313'

      click_button

      expect(page).to have_message(I18n.t('errors.messages.invalid'), in: 'div.contact_phone')
      expect(page).to have_message(I18n.t('errors.messages.invalid'), in: 'div.contact_email')
    end
  end

  context 'with invalid token' do
    it 'update contact' do
      visit contact_edit_path(contact_with_invalid_token,
                              contact_with_invalid_token.update_data_token)

      expect(page).to have_current_path contact_time_exceeded_path
    end
  end

  # context 'when already unregistered' do
  #   it 'update contact' do
  #     token = 'df4d5f4d5d45fss5d4s5d4s5d45'
  #     puts contact.unregister_token
  #     patch contact_confirm_unregister_path(contact, token)
  #
  #     expect(page).to have_current_path contact_already_unregistered_path
  #   end
  # end
end
