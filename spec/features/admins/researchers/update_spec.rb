require 'rails_helper'

describe 'Admin::Reseracher::update', type: :feature, js: true do
  let(:admin) { create(:admin) }
  let(:resource_name) { Researcher.model_name.human }
  let!(:institution) { create_list(:institution, 2).sample }
  let(:scholarity) { create_list(:scholarity, 2).sample }
  let(:researcher) { create(:researcher) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit edit_admins_researcher_path(researcher)
  end

  context 'when render edit' do
    it 'fields should be filled' do
      expect(page).to have_field('researcher_name', with: researcher.name)
      # expect(page).to have_field('researcher_genre', with: researcher.genre)
      expect(page).to have_selectize('researcher_scholarity',
                                     selected: researcher.scholarity.name)
      expect(page).to have_selectize('researcher_institution',
                                     selected: researcher.institution.name)
    end
  end

  context 'with valid fields' do
    it 'update researcher' do
      new_name = 'Nome Teste'
      new_genre = 'Feminino'
      action_name = 'flash.actions.update.m'

      fill_in 'researcher_name', with: new_name
      choose(new_genre)

      selectize researcher.scholarity.name, from: 'researcher_scholarity_id'
      selectize researcher.institution.name, from: 'researcher_institution_id'

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
      click_button

      expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.researcher_name')
    end
  end
end
