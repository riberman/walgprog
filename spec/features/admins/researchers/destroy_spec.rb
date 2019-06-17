require 'rails_helper'

describe 'Admins::Reseracher::destroy', type: :feature do
  let(:resource_name) { Researcher.model_name.human }
  let(:admin) { create(:admin) }
  let!(:researcher) { create(:researcher) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_researchers_path
  end

  it 'delete an researcher', js: true do
    click_on_destroy_link(admins_researcher_path(researcher), alert: true)

    expect(page).to have_current_path admins_researchers_path
    success_message = I18n.t('flash.actions.destroy.m', resource_name: resource_name)
    expect(page).to have_flash(:success, text: success_message)

    within('table tbody') do
      expect(page).not_to have_content(researcher.name)
    end
  end
end
