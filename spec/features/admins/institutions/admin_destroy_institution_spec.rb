require 'rails_helper'
describe 'Institution:destroy', type: :feature do
  let(:admin) { create(:admin) }
  let!(:institution) { create(:institution) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_institutions_path
  end

  it 'delete the institution', js: true do
    first('.destroy').click

    alert = page.driver.browser.switch_to.alert
    alert.accept
    sleep 2.seconds

    success_message = I18n.t('institutions.success.destroy')
    expect(page).to have_flash(:success, text: success_message)

    expect(page).not_to have_content(institution.name)
  end
end
