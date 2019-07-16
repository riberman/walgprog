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

  context 'when data is valid' do
    it 'create section active' do
      attributes = attributes_for(:section)

      fill_in 'section_title', with: attributes[:title]
      fill_in 'section_content_md', with: attributes[:content_md], visible: false
      choose('section_status_active', visible: false)
      fill_in 'section_icon', with: attributes[:icon]
      click_button

      expect(page).to have_current_path admins_event_sections_path(event)
      success_message = I18n.t('flash.actions.create.f', resource_name: resource_name)
      expect(page).to have_flash(:success, text: success_message)

      within('table tbody tr:last') do
        icon_class = page.find('td:nth-child(2) i')[:class]
        expect(icon_class).to eq(attributes[:icon])

        expect(page).to have_content(attributes[:title])
        expect(page).to have_content(I18n.t('enums.section_statuses.active'))
      end
    end

    it 'create section alternative_content', js: true do
      attributes = attributes_for(:section)

      fill_in 'section_icon', with: attributes[:icon]
      find('div.iconpicker-items a[title=".fab fa-accessible-icon"]').click

      fill_in 'section_title', with: attributes[:title]

      content_md = "WAlgProg.simpleMDEInstances['section_content_md'].value('# Test')"
      page.execute_script(content_md)

      choose_radio(I18n.t('enums.section_statuses.alternative_content'), from: 'section_status')

      at_md = "WAlgProg.simpleMDEInstances['section_alternative_content_md'].value('# Test')"
      page.execute_script(at_md)

      click_button

      expect(page).to have_current_path admins_event_sections_path(event)
      success_message = I18n.t('flash.actions.create.f', resource_name: resource_name)
      expect(page).to have_flash(:success, text: success_message)

      within('table tbody') do
        icon_class = page.find('tr td:nth-child(2) i')[:class]
        expect(icon_class).to eq('fab fa-accessible-icon')

        expect(page).to have_content(attributes[:title])
        expect(page).to have_content(I18n.t('enums.section_statuses.alternative_content'))
      end
    end
  end

  context 'when data are not valid' do
    it 'show errors' do
      click_button

      expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.section_title')
      expect(page).to have_message(message_blank_error, in: 'div.section_icon')
      expect(page).to have_message(message_blank_error, in: 'div.section_status')
      expect(page).to have_message(message_blank_error, in: 'div.section_content_md')
    end

    it 'with alternative_content', js: true do
      choose_radio(I18n.t('enums.section_statuses.alternative_content'), from: 'section_status')
      click_button

      expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))
      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.section_icon')
      expect(page).to have_message(message_blank_error, in: 'div.section_title')
      expect(page).to have_message(message_blank_error, in: 'div.section_content_md')
      expect(page).to have_message(message_blank_error, in: 'div.section_alternative_content_md')
    end
  end
end
