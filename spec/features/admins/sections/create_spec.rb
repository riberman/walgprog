require 'rails_helper'

describe 'Admins::Section::create', type: :feature do
  let(:resource_name) { Section.model_name.human }
  let(:admin) { create(:admin) }
  let!(:event) { create(:event) }
  let(:section) { create(:section) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit new_admins_event_section_path(event)
  end

  context 'when data is valid', js: true do
    it 'create section' do
      active = Section.human_status_types.keys.first
      attributes = attributes_for(:section)

      fill_in 'section_title', with: attributes[:title]
      fill_in 'section_content_markdown', with: attributes[:content_markdown]
      select attributes[:icon], from: 'section_icon'
      selectize(active, from: 'section_status', normalize_id: false)
      click_button('commit')

      expect(page).to have_current_path admins_event_sections_path(event)

      success_message = I18n.t('flash.actions.create.f', resource_name: resource_name)
      expect(page).to have_flash(:success, text: success_message)

      within('table tbody') do
        expect(page).to have_content(attributes[:title])
        expect(page).to have_content(active)
        expect(page).to have_content(attributes[:alternative_text])
        expect(page).to have_content(attributes[:index])
        expect(page).to have_css "td .fa-#{attributes[:icon]}"
        expect(page).to have_content(I18n.l(Event.last.created_at, format: :short))
      end
    end
  end

  context 'when data are not valid' do
    it 'show errors', js: true do
      click_button('commit')

      expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.section_title')
      expect(page).to have_message(message_blank_error, in: 'div.section_icon')
      expect(page).to have_message(message_blank_error, in: 'div.section_status')
      expect(page).to have_message(message_blank_error, in: 'div.section_content_markdown')
    end

    it 'with alternative_text', js: true do
      other = I18n.t('enums.status_types.other')
      selectize(other, from: 'section_status', normalize_id: false)
      click_button('commit')

      expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.section_alternative_text')
      expect(page).to have_message(message_blank_error, in: 'div.section_title')
      expect(page).to have_message(message_blank_error, in: 'div.section_icon')
      expect(page).to have_message(message_blank_error, in: 'div.section_content_markdown')
    end
  end
end
