require 'rails_helper'

describe 'Admins::Institution::update', type: :feature do
  let(:resource_name) { Institution.model_name.human }
  let(:admin) { create(:admin) }
  let!(:institution) { create(:institution) }
  let!(:city) { create(:city) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit edit_admins_institution_path(institution)
  end

  context 'when render edit', js: true do
    it 'filled the fields correctly' do
      expect(page).to have_field('institution_name', with: institution.name)
      expect(page).to have_field('institution_acronym', with: institution.acronym)

      expect(page).to have_selectize('institution_state_id', selected: institution.city.state.name)
      expect(page).to have_selectize('institution_city_id', selected: institution.city.name)
    end
  end

  context 'whith valid fields', js: true do
    it 'update event' do
      new_name = 'new institution name'
      new_acronym = 'new institution acronym'

      fill_in 'institution_name', with: new_name
      fill_in 'institution_acronym', with: new_acronym
      selectize(city.state.name, from: 'institution_state_id')
      selectize(city.name, from: 'institution_city_id')
      click_button

      expect(page).to have_current_path admins_institutions_path

      success_message = I18n.t('flash.actions.update.f', resource_name: resource_name)
      expect(page).to have_flash('success', text: success_message)

      within('table tbody') do
        expect(page).to have_content(new_name)
        expect(page).to have_content(new_acronym)
        expect(page).to have_content(city.name)
        expect(page).to have_content(city.state.acronym)
      end
    end
  end

  context 'whith invalid fields', js: true do
    it 'show errors' do
      fill_in 'institution_name', with: ''
      fill_in 'institution_acronym', with: ''
      selectize('', from: 'institution_state_id')
      selectize('', from: 'institution_city_id')
      click_button

      expect(page).to have_current_path admins_institution_path(institution)
      expect(page).to have_flash('danger', text: I18n.t('flash.actions.errors'))

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.institution_name')
      expect(page).to have_message(message_blank_error, in: 'div.institution_acronym')
      expect(page).to have_message(message_blank_error, in: 'div.institution_state_id')
      expect(page).to have_message(message_blank_error, in: 'div.institution_city_id')
    end

    it 'not change state and city' do
      fill_in 'institution_acronym', with: ''
      click_button

      expect(page).to have_selectize('institution_state_id', selected: institution.city.state.name)
      expect(page).to have_selectize('institution_city_id', selected: institution.city.name)
    end

    it 'if state is changed keep it' do
      fill_in 'institution_acronym', with: ''
      selectize(city.state.name, from: 'institution_state_id')
      click_button

      expect(page).to have_selectize('institution_state_id', selected: city.state.name)
    end

    it 'if state and city are changed keep both' do
      fill_in 'institution_acronym', with: ''
      selectize(city.state.name, from: 'institution_state_id')
      selectize(city.name, from: 'institution_city_id')
      click_button

      expect(page).to have_selectize('institution_state_id', selected: city.state.name)
      expect(page).to have_selectize('institution_city_id', selected: city.name)
    end
  end

  context 'when Breadcrumbs have the correct' do
    it 'text' do
      i = 0
      breadcrumbs_text = [I18n.t('breadcrumbs.homepage'),
                          '/',
                          I18n.t('breadcrumbs.action.index',
                                 resource_name: I18n.t('activerecord.models.institution.other')),
                          '/',
                          I18n.t('breadcrumbs.action.edit',
                                 resource_name: I18n.t('activerecord.models.institution.one'))]
      all('li').each do |li|
        expect(li.text).to have_content(breadcrumbs_text[i])
        i += 1
      end
    end

    it 'url' do
      expected_paths = ['/admins',
                        '/admins/institutions',
                        '/admins/institutions/' + institution.id.to_s + '/edit']
      i = 0
      all('li a').each do |a|
        expect(a[:href]).to have_content(expected_paths[i])
        i += 1
      end
    end
  end
end
