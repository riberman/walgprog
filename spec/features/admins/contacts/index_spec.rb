require 'rails_helper'

describe 'Admins::Contact::index', type: :feature do
  let(:admin) { create(:admin) }
  let!(:contacts) { create_list(:contact, 3) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_contacts_path
  end

  it 'show all contacts in table' do
    within('table tbody') do
      contacts.each do |contact|
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
