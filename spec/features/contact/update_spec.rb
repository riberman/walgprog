require 'rails_helper'

describe 'Contact::update', type: :feature do
  let(:contact) { create(:contact) }

  context 'when render edit' do
    it 'fields should be filled' do
      visit contact_edit_path(contact, contact.update_data_token)
      expect(page).to have_field('contact_name', with: contact.name)
      expect(page).to have_field('contact_email', with: contact.email)
      expect(page).to have_field('contact_phone', with: contact.phone)
      # expect(page).to have_selectize('contact_institution', selected: contact.institution.name)
    end
  end

  # context 'with valid fields' do
  #   it 'update contact' do
  #     local_name = 'Novo Nome'
  #     local_email = 'novo@mail.com'
  #     local_phone = '(42) 99955-3214'
  #     action_name = 'flash.actions.update.m'
  #
  #     fill_in 'contact_name', with: local_name
  #     fill_in 'contact_email', with: local_email
  #     fill_in 'contact_phone', with: local_phone
  #     # selectize institution.name, from: 'contact_institution'
  #
  #     click_button
  #
  #     expect(page).to have_current_path admins_contacts_path
  #   end
  # end
end
