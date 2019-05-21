require 'rails_helper'

describe 'Researcher:create', type: :feature do
  let(:admin) { create(:admin) }
  let!(:institution) { create_list(:institution, 2).sample }

  before(:each) do
    login_as(admin, scope: :admin)
    visit new_admins_researcher_path
  end

  it 'try to create with invalid fields' do
    click_button

    message_blank_error = I18n.t('errors.messages.blank')
    expect(page).to have_message(message_blank_error, in: 'div.researcher_name')
    expect(page).to have_message(message_blank_error, in: 'div.researcher_title')
    expect(page).to have_message(message_blank_error, in: 'div.researcher_academic_title')
    expect(page).to have_message(message_blank_error, in: 'div.researcher_image')
    expect(page).to have_message(message_blank_error, in: 'div.researcher_institution_affiliation')
    expect(page).to have_message(message_blank_error, in: 'div.researcher_genre')

    message_error = I18n.t('simple_form.error_notification.default_message')
    expect(page).to have_current_path admins_researchers_path
    expect(page).to have_selector('div.alert.alert-danger',
                                  text: message_error)
  end

  it 'try to create with valid fields' do
    attributes = attributes_for(:researcher)
    fill_in 'researcher_name', with: attributes[:name]
    fill_in 'researcher_title', with: attributes[:title]
    fill_in 'researcher_academic_title', with: attributes[:academic_title]
    choose(option: 'Feminino')
    attach_file 'researcher_image', FileSpecHelper.image.path

    select institution.name, from: 'researcher_institution_affiliation'

    click_button
    success_message = I18n.t('researchers.success.new')
    expect(page).to have_current_path admins_researchers_path

    expect(page).to have_selector('div.alert.alert-success', text: success_message)
  end
end
