require 'rails_helper'

describe 'Researcher:destroy', type: :feature do
  let(:admin) { create(:admin) }
  let!(:researcher) { create(:researcher) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_researchers_path
  end

  it 'delete the institution', js: true do
    first('.destroy').click

    alert = page.driver.browser.switch_to.alert
    alert.accept
    sleep 2.seconds

    success_message = I18n.t('researchers.success.destroy')
    expect(page).to have_flash(:success, text: success_message)

    expect(page).not_to have_content(researcher.name)
    expect(page).not_to have_content(researcher.title)
    expect(page).not_to have_content(researcher.academic_title)
    expect(page).not_to have_content(researcher.institution.name)
  end
end
