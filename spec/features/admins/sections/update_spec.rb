require 'rails_helper'

describe 'Admins::Section::update', type: :feature do
  let(:resource_name) { Section.model_name.human }
  let(:admin) { create(:admin) }
  let!(:event) { create(:event) }
  let(:section) { create(:section) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit edit_admins_event_section_path(event, section)
  end

  context 'when render edit', js: true do
    it 'filled the fields correctly' do
      status = I18n.t("enums.status_types.#{section.status}")
      expect(page).to have_field('section_title', with: section.title)
      expect(page).to have_field('section_icon', with: section.icon)
      expect(page).to have_field('section_index', disabled: true, with: section.index)
      expect(page).to have_field('section_content', with: section.content)

      expect(page).to have_selectize('section_status', selected: status)
    end
  end

  context 'when data is valid', js: true do
    it 'update section with inactive status' do
      inactive = Section.human_status_types.keys.second
      fill_in 'section_title', with: 'new title'
      fill_in 'section_content', with: 'new content'
      select 'glass', from: 'section_icon'
      selectize(inactive, from: 'section_status', normalize_id: false)
      click_button

      expect(page).to have_current_path admins_event_sections_path(event)

      success_message = I18n.t('flash.actions.update.f', resource_name: resource_name)
      expect(page).to have_flash(:success, text: success_message)

      within('table tbody') do
        expect(page).to have_content('new title')
        expect(page).to have_content(I18n.t('enums.status_types.inactive'))
        expect(page).to have_content(section.index)
        expect(page).to have_content(I18n.l(Event.last.created_at, format: :short))
      end
    end

    it 'update section with other status' do
      other = Section.human_status_types.keys.third
      fill_in 'section_title', with: 'new title'
      fill_in 'section_content', with: 'new content'
      select 'glass', from: 'section_icon'
      selectize(other, from: 'section_status', normalize_id: false)
      fill_in 'section_alternative_text', with: 'other status'
      click_button

      expect(page).to have_current_path admins_event_sections_path(event)

      success_message = I18n.t('flash.actions.update.f', resource_name: resource_name)
      expect(page).to have_flash(:success, text: success_message)

      within('table tbody') do
        expect(page).to have_content('new title')
        expect(page).to have_content(I18n.t('enums.status_types.other'))
        expect(page).to have_content('other status')
        expect(page).to have_content(section.index)
        expect(page).to have_content(I18n.l(Event.last.created_at, format: :short))
      end
    end
  end

  context 'when data are not valid', js: true do
    it 'show errors' do
      fill_in 'section_title', with: ''
      fill_in 'section_content', with: ''
      selectize('', from: 'section_status', normalize_id: false)
      click_button

      expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.section_title')
      expect(page).to have_message(message_blank_error, in: 'div.section_content')
      expect(page).to have_message(message_blank_error, in: 'div.section_status')
    end

    it 'not register with other status without text' do
      other = I18n.t('enums.status_types.other')
      selectize(other, from: 'section_status', normalize_id: false)
      click_button

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.section_alternative_text')
    end
  end
end
