require 'rails_helper'

describe 'Admins::Contact::index', type: :feature do
  let(:admin) { create(:admin) }
  let!(:contacts) { create_list(:contact, 3) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_contacts_path
  end

  context 'with data' do
    it 'showed' do
      within('table tbody') do
        contacts.each do |contact|
          expect(page).to have_content(contact.name)
          expect(page).to have_content(contact.email)
          expect(page).to have_content(contact.institution.acronym)
          expect(page).to have_content(I18n.t("helpers.boolean.#{contact.unregistered}"))

          expect(page).to have_link(href: admins_contact_path(contact))
          expect(page).to have_link(href: edit_admins_contact_path(contact))
          expect(page).to have_destroy_link(href: admins_contact_path(contact))
        end
      end
    end
  end

  context 'with links' do
    it { expect(page).to have_link(I18n.t('contacts.new'), href: new_admins_contact_path) }
  end
end
