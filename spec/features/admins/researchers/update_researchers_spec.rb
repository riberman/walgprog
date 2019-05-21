require 'rails_helper'

describe 'Researcher:update', type: :feature do
  let(:admin) { create(:admin) }
  let(:researcher) { create(:researcher) }
  let!(:institution) { create_list(:institution, 2).sample }

  before(:each) do
    login_as(admin, scope: :admin)
    visit edit_admins_researcher_path(researcher)
  end

  context 'when a researcher is updated' do
    it 'update researcher' do
      new_name = 'New Name'
      fill_in 'researcher_name', with: new_name

      new_title = 'New Title'
      fill_in 'researcher_title', with: new_title

      new_academic_title = 'New Academic Title'
      fill_in 'researcher_academic_title', with: new_academic_title

      new_genre = 'Masculino'
      choose(new_genre)

      new_institution = institution.name
      attach_file 'researcher_image', FileSpecHelper.image.path
      select new_institution, from: 'researcher_institution_affiliation'

      click_button

      expect(page).to have_current_path admins_researchers_path

      success_message = I18n.t('researchers.success.edit')
      expect(page).to have_flash(:success, text: success_message)
      expect(page).to have_content(new_name)
      expect(page).to have_content(new_title)
      expect(page).to have_content(new_academic_title)
      expect(page).to have_content(new_institution)
    end
  end

  context 'when researcher is not updated' do
    it 'show errors - blank name' do
      fill_in 'researcher_name', with: ''
      fill_in 'researcher_title', with: ''
      fill_in 'researcher_academic_title', with: ''
      attach_file 'researcher_image', FileSpecHelper.pdf.path

      click_button

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.researcher_name')
      expect(page).to have_message(message_blank_error, in: 'div.researcher_title')
      expect(page).to have_message(message_blank_error, in: 'div.researcher_academic_title')
      expect(page).to have_message(message_blank_error, in: 'div.researcher_image')
      expect(page).to have_message(message_blank_error,
                                   in: 'div.researcher_institution_affiliation')
      error_default_message = I18n.t('simple_form.error_notification.default_message')
      expect(page).to have_flash(:danger, text: error_default_message)
    end
  end
end
