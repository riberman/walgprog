require 'rails_helper'

describe 'Admins::Researchers::create', type: :feature, js: true do
  let(:admin) { create(:admin) }
  let(:resource_name) { Researcher.model_name.human }
  let!(:institution) { create_list(:institution, 2).sample }
  let!(:scholarity) { create_list(:scholarity, 2).sample }

  before(:each) do
    login_as(admin, scope: :admin)
    visit new_admins_researcher_path
  end

  context 'with valid fields' do
    it 'create a researcher' do
      Capybara.ignore_hidden_elements = false

      attributes = attributes_for(:researcher)
      action_name = 'flash.actions.create.m'

      fill_in 'researcher_name', with: attributes[:name]
      selectize institution.name, from: 'researcher_institution'
      selectize scholarity.name, from: 'researcher_scholarity'
      attach_file 'researcher_image', FileSpecHelper.image.path
      choose_radio(I18n.t("enums.genders.#{attributes[:gender]}"), from: 'researcher_gender')
      click_button

      expect(page).to have_current_path admins_researchers_path
      expect(page).to have_flash(:success, text: I18n.t(action_name, resource_name: resource_name))

      within('table tbody') do
        expect(page).to have_content(attributes[:name])
        expect(page).to have_content(scholarity.name)
        expect(page).to have_content(institution.name)
      end
    end
  end

  context 'with fields' do
    it 'filled blank show errors' do
      click_button

      expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.researcher_name')
      expect(page).to have_message(message_blank_error, in: 'div.researcher_gender')
      expect(page).to have_message(I18n.t('errors.messages.required'),
                                   in: 'div.researcher_institution')
      expect(page).to have_message(I18n.t('errors.messages.required'),
                                   in: 'div.researcher_scholarity')
    end
  end
end
