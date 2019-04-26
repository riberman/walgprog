require 'rails_helper'

describe 'Admin Contact', type: :feature do
  let(:admin) { create(:admin) }
  let(:resource_name) { Contact.model_name.human }
  let!(:institution) { create_list(:institution, 2).sample }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    before(:each) do
      visit new_admins_contact_path
    end

    context 'with valid fields' do
      it 'when click in butto should create contact and redirect to index contact' do
        attributes = attributes_for(:contact)
        action_name = 'flash.actions.create.m'

        fill_in 'contact_name', with: attributes[:name]
        fill_in 'contact_email', with: attributes[:email]
        select institution.name, from: 'contact_institution_id'

        click_button

        expect(page).to have_current_path admins_contacts_path
        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t(action_name, resource_name: resource_name))

        within('table tbody') do
          expect(page).to have_content(attributes[:name])
        end
      end
    end

    context 'with invalid fields' do
      it 'when clicn in button should show errors in fields' do
        click_button

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        have_contains('div.contact_name', I18n.t('errors.messages.blank'))
        have_contains('div.contact_email', I18n.t('errors.messages.blank'))
        have_contains('div.contact_institution', I18n.t('errors.messages.blank'))
      end
    end
  end

  describe '#update' do
    before(:each) do
      contact = create :contact
      visit edit_admins_contact_path(contact)
    end

    context 'with valid fields' do
      it 'when click in button should update contact and redirec to index page contact' do
        local_name = 'Guilherme Ribas Carneiro'
        local_email = 'guilherme@hotmail.com'
        local_phone = '42998533012'
        action_name = 'flash.actions.update.m'

        fill_in 'contact_name', with: local_name
        fill_in 'contact_email', with: local_email
        fill_in 'contact_phone', with: local_phone
        select institution.name, from: 'contact_institution_id'

        click_button

        expect(page).to have_current_path admins_contacts_path

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t(action_name, resource_name: resource_name))
      end
    end

    context 'with fields blank' do
      it 'when invalid params value should return error in field' do
        local_name = ''
        local_email = ''
        local_phone = ''

        fill_in 'contact_name', with: local_name
        fill_in 'contact_email', with: local_email
        fill_in 'contact_phone', with: local_phone

        click_button

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        have_contains('div.contact_name', I18n.t('errors.messages.blank'))
        have_contains('div.contact_email', I18n.t('errors.messages.blank'))
        have_contains('div.contact_institution', I18n.t('errors.messages.blank'))
      end
    end
  end

  describe '#destroy' do
    it 'when attemp remove contact should have message with warn and click action remove contact' do
      action_name = 'flash.actions.destroy.m'

      contact = create :contact
      contact_name = contact.name
      visit admins_contacts_path

      destroy_link = "a[href='#{admins_contact_path(contact)}'][data-method='delete']"
      find(destroy_link).click

      expect(page).to have_current_path admins_contacts_path
      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t(action_name, resource_name: contact_name))
    end
  end

  describe '#index' do
    let!(:contacts) { create_list(:contact, 5) }

    it 'when access page contacts should have all contacts in table' do
      visit admins_contacts_path

      contacts.each do |contact|
        within('table tbody') do
          expect(page).to have_content(contact.name)
          expect(page).to have_content(contact.email)
          expect(page).to have_content(contact.institution.acronym)

          expect(page).to have_link(href: admins_contact_path(contact))
          expect(page).to have_link(href: edit_admins_contact_path(contact))
          destroy_link = "a[href='#{admins_contact_path(contact)}'][data-method='delete']"
          expect(page).to have_css(destroy_link)
        end
      end
    end
  end

  describe '#show' do
    context 'when show contact' do
      it 'view contact show data' do
        contact = create(:contact)
        visit admins_contact_path(contact)

        expect(page).to have_content(contact.name)
        expect(page).to have_content(contact.email)
        expect(page).to have_content(contact.institution.name)
      end
    end
  end
end
