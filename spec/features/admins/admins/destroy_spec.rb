require 'rails_helper'

describe 'Admins::Admin::destroy', type: :feature do
  let(:resource_name) { Admin.model_name.human }
  let(:admin) { create(:admin) }
  let!(:admins) { create_list(:admin, 3) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_admins_path
  end

  context 'with data' do
    it 'show message and redirect_to index' do
      admins.each do |admin|
        click_on_destroy_link(admins_admin_path(admin))

        expect(page).to have_current_path admins_admins_path
        success_message = I18n.t('flash.actions.destroy.m', resource_name: resource_name)
        expect(page).to have_flash(:success, text: success_message)

        within('table tbody') do
          expect(page).not_to have_content(admin.email)
        end
      end
    end
  end
end
