require 'rails_helper'

describe 'Admins::Section::update', type: :feature do
  let(:resource_name) { Section.model_name.human }
  let(:admin) { create(:admin) }
  let(:event) { create(:event) }
  let!(:section) { create(:section, event: event) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit edit_admins_event_section_path(event, section)
  end

  context 'when render edit' do
    it 'filled the fields' do
      expect(page).to have_field('section_position', disabled: true, with: section.position)
      expect(page).to have_field('section_icon', with: section.icon)
      expect(page).to have_field('section_title', with: section.title)
      expect(page).to have_field('section_content_md', with: section.content_md, visible: false)

      radio_button = "section_status_#{section.status}"
      expect(find_field(radio_button, visible: false).checked?).to be true
    end

    it 'filled the alternative text' do
      section.update(status: 'alternative_content')
      visit edit_admins_event_section_path(event, section)

      expect(page).to have_field('section_position', disabled: true, with: section.position)
      expect(page).to have_field('section_icon', with: section.icon)
      expect(page).to have_field('section_title', with: section.title)
      expect(page).to have_field('section_content_md', with: section.content_md, visible: false)

      radio_button = "section_status_#{section.status}"
      expect(find_field(radio_button, visible: false).checked?).to be true
      expect(page).to have_field('section_alternative_content_md',
                                 with: section.alternative_content_md, visible: false)
    end
  end

  context 'when data is valid' do
    it 'update section with inactive status' do
      attributes = attributes_for(:section)

      fill_in 'section_title', with: attributes[:title]
      fill_in 'section_content_md', with: attributes[:content_md], visible: false
      choose('section_status_active', visible: false)
      fill_in 'section_icon', with: attributes[:icon]
      click_button

      expect(page).to have_current_path admins_event_section_path(event, section)
      success_message = I18n.t('flash.actions.update.f', resource_name: resource_name)
      expect(page).to have_flash(:success, text: success_message)

      section.reload
      within('.card-header') do
        expect(page).to have_content(I18n.t('sections.show', event: section.event.name))
      end

      within('.card-body') do
        expect(page).to have_content(section.position)
        icon_class = page.find('fieldset .row div:nth-child(2) i')[:class]
        expect(icon_class).to eq(section.icon)
        expect(page).to have_content(section.title)
        expect(page).to have_content(I18n.t("enums.section_statuses.#{section.status}"))
        expect(page).to have_content(I18n.l(section.created_at, format: :short))

        expect(page.body).to include(section.content)
        expect(page.body).to include(section.alternative_content)
      end
    end

    it 'update section with alternative_content', js: true do
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

      expect(page).to have_current_path admins_event_section_path(event, section)
      success_message = I18n.t('flash.actions.update.f', resource_name: resource_name)
      expect(page).to have_flash(:success, text: success_message)

      section.reload
      within('.card-header') do
        expect(page).to have_content(I18n.t('sections.show', event: section.event.name))
      end

      within('.card-body') do
        expect(page).to have_content(section.position)
        icon_class = page.find(:css, 'fieldset .row div:nth-child(2) i')[:class]
        expect(icon_class).to eq(section.icon)
        expect(page).to have_content(section.title)
        expect(page).to have_content(I18n.t("enums.section_statuses.#{section.status}"))
        expect(page).to have_content(I18n.l(section.created_at, format: :short))

        expect(page.body).to include(section.content)
        expect(page.body).to include(section.alternative_content)
      end
    end
  end

  context 'when data are not valid', js: true do
    it 'show errors' do
      fill_in 'section_icon', with: ''
      fill_in 'section_title', with: ''

      content_md = "WAlgProg.simpleMDEInstances['section_content_md'].value('')"
      page.execute_script(content_md)

      choose_radio(I18n.t('enums.section_statuses.alternative_content'), from: 'section_status')

      ac_md = "WAlgProg.simpleMDEInstances['section_alternative_content_md'].value('')"
      page.execute_script(ac_md)
      sleep 10
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
