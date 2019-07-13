require 'rails_helper'

describe 'Admins::Contact::index', type: :feature do
  let(:admin) { create(:admin) }
  let!(:registered_contacts) { create_list(:contact, 2) }
  let!(:unregistered_contacts) { create_list(:contact, 2, unregistered: true) }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  context 'with only registered contacts' do
    it 'show' do
      visit admins_contacts_registered_path
      within('table tbody') do
        registered_contacts.each do |contact|
          expect(page).to have_content(contact.name)
          expect(page).to have_content(contact.email)
          expect(page).to have_content(contact.institution.acronym)

          expect(page).to have_link(href: admins_contact_path(contact))
          expect(page).to have_link(href: edit_admins_contact_path(contact))
          expect(page).to have_destroy_link(href: admins_contact_path(contact))
        end
      end
    end

    it 'not show' do
      visit admins_contacts_registered_path
      within('table tbody') do
        unregistered_contacts.each do |contact|
          expect(page).not_to have_content(contact.name)
          expect(page).not_to have_content(contact.email)
          expect(page).not_to have_content(contact.institution.acronym)

          expect(page).not_to have_link(href: admins_contact_path(contact))
          expect(page).not_to have_link(href: edit_admins_contact_path(contact))
          expect(page).not_to have_destroy_link(href: admins_contact_path(contact))
        end
      end
    end

    it 'with links' do
      visit admins_contacts_registered_path
      expect(page).to have_link(I18n.t('contacts.new'),
                                href: new_admins_contact_path)
      expect(page).to have_link(I18n.t('contacts.registered'),
                                href: admins_contacts_registered_path)
      expect(page).to have_link(I18n.t('contacts.unregistered'),
                                href: admins_contacts_unregistered_path)
    end
  end

  context 'with only unregistered contacts' do
    it 'show' do
      visit admins_contacts_unregistered_path
      within('table tbody') do
        unregistered_contacts.each do |contact|
          expect(page).to have_content(contact.name)
          expect(page).to have_content(contact.email)
          expect(page).to have_content(contact.institution.acronym)

          expect(page).to have_link(href: admins_contact_path(contact))
          expect(page).to have_link(href: edit_admins_contact_path(contact))
          expect(page).to have_destroy_link(href: admins_contact_path(contact))
        end
      end
    end

    it 'not show' do
      visit admins_contacts_unregistered_path
      within('table tbody') do
        registered_contacts.each do |contact|
          expect(page).not_to have_content(contact.name)
          expect(page).not_to have_content(contact.email)
          expect(page).not_to have_content(contact.institution.acronym)

          expect(page).not_to have_link(href: admins_contact_path(contact))
          expect(page).not_to have_link(href: edit_admins_contact_path(contact))
          expect(page).not_to have_destroy_link(href: admins_contact_path(contact))
        end
      end
    end

    it 'with links' do
      visit admins_contacts_unregistered_path
      expect(page).to have_link(I18n.t('contacts.new'),
                                href: new_admins_contact_path)
      expect(page).to have_link(I18n.t('contacts.registered'),
                                href: admins_contacts_registered_path)
      expect(page).to have_link(I18n.t('contacts.unregistered'),
                                href: admins_contacts_unregistered_path)
    end
  end
end
