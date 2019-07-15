require 'rails_helper'

describe 'Admins::Contact::create', type: :feature do
  let(:admin) { create(:admin) }
  let(:resource_name) { Contact.model_name.human }
  let!(:institution) { create_list(:institution, 2).sample }

  before(:each) do
    login_as(admin, scope: :admin)
    visit new_admins_contact_path
  end

  context 'with valid fields', js: true do
    it 'create a contact' do
      attributes = attributes_for(:contact)
      action_name = 'flash.actions.create.m'

      fill_in 'contact_name', with: attributes[:name]
      fill_in 'contact_email', with: attributes[:email]
      fill_in 'contact_phone', with: attributes[:phone]
      selectize institution.name, from: 'contact_institution'
      click_button

      expect(page).to have_current_path admins_contacts_path
      expect(page).to have_flash(:success, text: I18n.t(action_name, resource_name: resource_name))

      within('table tbody') do
        expect(page).to have_content(attributes[:name])
        expect(page).to have_content(attributes[:email])
        expect(page).to have_content(institution.acronym)
        expect(page).to have_content(I18n.t('helpers.boolean.false'))
      end
    end
  end

  context 'with fields', js: true do
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

    it 'phone and email invalids' do
      fill_in 'contact_email', with: 'email'
      fill_in 'contact_phone', with: '131313'

      click_button

      expect(page).to have_message(I18n.t('errors.messages.invalid'), in: 'div.contact_phone')
      expect(page).to have_message(I18n.t('errors.messages.invalid'), in: 'div.contact_email')
    end
  end
end
