require 'rails_helper'
describe 'Institution', type: :feature do
  let(:institution) { create(:institution) }
  let(:admin) { create(:admin) }
  let!(:city) { create_list(:city, 5).sample }

  before(:each) do
    login_as(admin, scope: :admin)
    visit new_admins_institution_path
  end

  it 'try to create with invalid fields' do
    click_button

    within('.institution_name') do
      expect(page).to have_content('não pode ficar em branco')
    end
    within('.institution_acronym') do
      expect(page).to have_content('não pode ficar em branco')
    end
    within('.institution_city') do
      expect(page).to have_content('é obrigatório')
    end
    expect(page).to have_current_path admins_institutions_path
    expect(page).to have_selector('div.alert.alert-danger',
                                  text: I18n.t('simple_form.error_notification.default_message'))
  end

  it 'try to create with valid fields', js: true do
    fill_in 'institution_name', with: 'Universidade Teste'
    fill_in 'institution_acronym', with: 'UT'
    state = State.first
    select(state.name, from: 'institution_state')
    select(state.cities.sample.name, from: 'institution_city')

    click_button

    expect(page).to have_current_path admins_institutions_path
    # expect(page).to have_selector('div.alert.alert-success',
    #                                 text: I18n.t('simple_form.'))
  end
end
