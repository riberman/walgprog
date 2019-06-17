require 'rails_helper'

describe 'Admin::Reseracher::update', type: :feature, js: true do
  let(:admin) { create(:admin) }
  let(:resource_name) { Researcher.model_name.human }
  let!(:institution) { create_list(:institution, 2).sample }
  let!(:scholarity) { create_list(:scholarity, 2).sample }
  let!(:researcher) { create(:researcher) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit edit_admins_researcher_path(researcher)
  end

  context 'when render edit' do
    it 'fields should be filled' do
      expect(page).to have_field('researcher_name', with: researcher.name)
      expect(page).to have_selectize('researcher_scholarity',
                                     selected: researcher.scholarity.name)
      expect(page).to have_selectize('researcher_institution',
                                     selected: researcher.institution.name)

      radio_button = "researcher_gender_#{researcher.gender}"
      expect(find_field(radio_button, visible: false).checked?).to be true
    end
  end

  context 'with valid fields' do
    it 'update researcher' do
      new_name = 'Nome Teste'
      new_gender = researcher.male_gender? ? 'male' : 'female'
      action_name = 'flash.actions.update.m'

      fill_in 'researcher_name', with: new_name
      choose_radio(I18n.t("enums.genders.#{new_gender}"), from: 'researcher_gender')
      selectize scholarity.name, from: 'researcher_scholarity'
      selectize institution.name, from: 'researcher_institution'
      click_button

      expect(page).to have_current_path admins_researchers_path
      expect(page).to have_flash(:success, text: I18n.t(action_name, resource_name: resource_name))

      within('table tbody') do
        expect(page).to have_content(new_name)
        expect(page).to have_content(scholarity.name)
        expect(page).to have_content(institution.name)
      end
    end
  end

  context 'with invalids fields' do
    it 'show errors when fields are blank' do
      fill_in 'researcher_name', with: ''
      selectize '', from: 'researcher_institution'
      selectize '', from: 'researcher_scholarity'
      click_button

      expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.researcher_name')
      expect(page).to have_message(I18n.t('errors.messages.required'),
                                   in: 'div.researcher_institution')
      expect(page).to have_message(I18n.t('errors.messages.required'),
                                   in: 'div.researcher_scholarity')
    end
  end
end
