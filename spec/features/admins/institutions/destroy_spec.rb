require 'rails_helper'

describe 'Admins::Institution::destroy', type: :feature do
  let(:resource_name) { Institution.model_name.human }
  let(:admin) { create(:admin) }
  let!(:institution) { create(:institution) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_institutions_path
  end

  it 'delete an institution', js: true do
    click_on_destroy_link(admins_institution_path(institution), alert: true)

    expect(page).to have_current_path admins_institutions_path
    success_message = I18n.t('flash.actions.destroy.f', resource_name: resource_name)
    expect(page).to have_flash(:success, text: success_message)

    within('table tbody') do
      expect(page).not_to have_content(institution.name)
    end
  end
end
