require 'rails_helper'
describe 'Institution:create', type: :feature do
  let(:institution) { create(:institution) }
  let(:admin) { create(:admin) }
  let!(:city) { create_list(:city, 5).sample }

  before(:each) do
    login_as(admin, scope: :admin)
    visit new_admins_institution_path
  end

  it 'try to create with invalid fields' do
    click_button

    message_blank_error = I18n.t('errors.messages.blank')
    expect(page).to have_message(message_blank_error, in: 'div.institution_name')
    expect(page).to have_message(message_blank_error, in: 'div.institution_acronym')
    expect(page).to have_message(message_blank_error, in: 'div.institution_city_id')

    message_error = I18n.t('simple_form.error_notification.default_message')
    expect(page).to have_current_path admins_institutions_path
    expect(page).to have_selector('div.alert.alert-danger',
                                  text: message_error)
  end

  it 'try to create with valid fields', js: true do
    fill_in 'institution_name', with: 'Universidade Teste'
    fill_in 'institution_acronym', with: 'UT'
    state = State.first
    select(state.name, from: 'institution_state_id')
    select(state.cities.sample.name, from: 'institution_city_id')

    click_button
    success_message = I18n.t('institutions.success.new')
    expect(page).to have_current_path admins_institutions_path

    expect(page).to have_selector('div.alert.alert-success', text: success_message)
  end
end
