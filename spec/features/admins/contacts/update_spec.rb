require 'rails_helper'

describe 'Admin::Contact::update', type: :feature do
  let(:admin) { create(:admin) }
  let(:resource_name) { Contact.model_name.human }
  let!(:institution) { create_list(:institution, 2).sample }
  let(:contact) { create_list(:contact, 2).sample }

  before(:each) do
    login_as(admin, scope: :admin)
    visit edit_admins_contact_path(contact)
  end

  context 'when render edit' do
    it 'fields should be filled' do
      expect(page).to have_field('contact_name', with: contact.name)
      expect(page).to have_field('contact_email', with: contact.email)
      expect(page).to have_field('contact_phone', with: contact.phone)
      expect(page).to have_select('contact_institution_id', selected: contact.institution.name)
    end
  end

  context 'with valid fields' do
    it 'update contact' do
      local_name = 'Guilherme Ribas Carneiro'
      local_email = 'guilherme@hotmail.com'
      local_phone = '(42) 99853-3012'
      action_name = 'flash.actions.update.m'

      fill_in 'contact_name', with: local_name
      fill_in 'contact_email', with: local_email
      fill_in 'contact_phone', with: local_phone
      select institution.name, from: 'contact_institution_id'

      click_button

      expect(page).to have_current_path admins_contacts_path
      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t(action_name, resource_name: resource_name))

      within('table tbody') do
        expect(page).to have_content(local_name)
        expect(page).to have_content(local_email)
        expect(page).to have_content(institution.acronym)
      end
    end
  end

  context 'with invalids fields' do
    it 'show errors when fields are blank' do
      fill_in 'contact_name', with: ''
      fill_in 'contact_email', with: ''
      fill_in 'contact_phone', with: ''

      click_button

      expect(page).to have_selector('div.alert.alert-danger',
                                    text: I18n.t('flash.actions.errors'))

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
end
