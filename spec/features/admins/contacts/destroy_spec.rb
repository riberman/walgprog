require 'rails_helper'

describe 'Admins::Contact::destroy', type: :feature do
  let(:admin) { create(:admin) }
  let(:resource_name) { Contact.model_name.human }
  let!(:contact) { create_list(:contact, 2).sample }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_contacts_path
  end

  it 'show message and redirect_to index' do
    click_on_destroy_link(admins_contact_path(contact))

    expect(page).to have_current_path admins_contacts_path
    success_message = I18n.t('flash.actions.destroy.m', resource_name: contact.name)
    expect(page).to have_flash(:success, text: success_message)

    within('table tbody') do
      expect(page).not_to have_content(contact.name)
      expect(page).not_to have_content(contact.email)
    end
  end
end
