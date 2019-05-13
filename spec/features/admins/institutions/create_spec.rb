require 'rails_helper'
describe 'Admins::Institution::create', type: :feature do
  let(:resource_name) { Institution.model_name.human }
  let(:admin) { create(:admin) }
  let!(:state) { create_list(:state, 2) }
  let!(:city) do
    create_list(:city, 2, state: State.first)
    create_list(:city, 2, state: State.last)
    City.all.sample
  end

  before(:each) do
    login_as(admin, scope: :admin)
    visit new_admins_institution_path
  end

  context 'with invalid fields' do
    it 'show errors' do
      click_button

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.institution_name')
      expect(page).to have_message(message_blank_error, in: 'div.institution_acronym')
      expect(page).to have_message(message_blank_error, in: 'div.institution_state_id')
      expect(page).to have_message(message_blank_error, in: 'div.institution_city_id')

      expect(page).to have_current_path admins_institutions_path
      expect(page).to have_flash('danger', text: I18n.t('flash.actions.errors'))
    end

    it 'when has a state selected', js: true do
      selectize(city.state.name, from: 'institution_state_id')
      click_button

      expect(page).to have_selectize('institution_state_id', selected: city.state.name)
    end

    it 'when has a state and city selected', js: true do
      selectize(city.state.name, from: 'institution_state_id')
      selectize(city.name, from: 'institution_city_id')
      click_button

      expect(page).to have_selectize('institution_state_id', selected: city.state.name)
      expect(page).to have_selectize('institution_city_id', selected: city.name)
    end
  end

  context 'with valid fields' do
    it 'create institution with valid fields', js: true do
      attributes = attributes_for(:institution)

      fill_in 'institution_name', with: attributes[:name]
      fill_in 'institution_acronym', with: attributes[:acronym]

      selectize(city.state.name, from: 'institution_state_id')
      selectize(city.name, from: 'institution_city_id')
      click_button

      expect(page).to have_current_path admins_institutions_path

      success_message = I18n.t('flash.actions.create.f', resource_name: resource_name)
      expect(page).to have_flash('success', text: success_message)

      within('table tbody') do
        expect(page).to have_content(attributes[:name])
        expect(page).to have_content(attributes[:acronym])
        expect(page).to have_content(city.name)
        expect(page).to have_content(city.state.acronym)
      end
    end
  end
end
