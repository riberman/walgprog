require 'rails_helper'

describe 'Admins::Contact::show', type: :feature do
  let(:admin) { create(:admin) }
  let(:contact) { create_list(:contact, 2).sample }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_contact_path(contact)
  end

  context 'with data' do
    it 'showed' do
      expect(page).to have_content(contact.name)
      expect(page).to have_content(contact.email)
      expect(page).to have_content(contact.phone)
      expect(page).to have_content(contact.institution.name)

      expect(page).to have_link(href: edit_admins_contact_path(contact))
      expect(page).to have_link(href: admins_contacts_path)
    end
  end

  context 'with links' do
    it do
      expect(page).to have_link(I18n.t('helpers.edit'), href: edit_admins_contact_path(contact))
    end
    it { expect(page).to have_link(I18n.t('helpers.back'), href: admins_contacts_path) }
  end
end
