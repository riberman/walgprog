require 'rails_helper'

describe 'Admin Contact Destroy', type: :feature do
  let(:admin) { create(:admin) }
  let(:resource_name) { Contact.model_name.human }
  let!(:contact) { create_list(:contact, 2).sample }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_contacts_path
  end

  it 'show message and redirect_to index' do
    action_name = 'flash.actions.destroy.m'

    destroy_link = "a[href='#{admins_contact_path(contact)}'][data-method='delete']"
    find(destroy_link).click

    expect(page).to have_current_path admins_contacts_path
    expect(page).to have_selector('div.alert.alert-success',
                                  text: I18n.t(action_name, resource_name: contact.name))

    within('table tbody') do
      expect(page).not_to have_content(contact.name)
      expect(page).not_to have_content(contact.email)
    end
  end
end
