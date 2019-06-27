require 'rails_helper'

describe 'Admins::Section::index', type: :feature do
  let(:admin) { create(:admin) }
  let!(:section) { create(:section) }
  let!(:sections) do
    create_list(:section, 5, event: section.event)
  end

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_event_sections_path(section.event)
  end

  context 'with data' do
    it 'showed' do
      within('table tbody') do
        sections.each do |section|
          expect(page).to have_content(section.title)
          expect(page).to have_content(I18n.t("enums.status_types.#{section.status}"))

          expect(page).to have_content(section.alternative_text)
          expect(page).to have_content(section.index)

          expect(page).to have_css "td .fa-#{section.icon}"
          expect(page).to have_content(I18n.l(section.created_at, format: :short))

          expect(page).to have_link(href: admins_event_section_path(section.event, section))
          expect(page).to have_link(href: edit_admins_event_section_path(section.event, section))
          expect(page).to have_destroy_link(href: admins_event_section_path(section.event, section))
        end
      end
    end
  end

  context 'with links' do
    it {
      expect(page).to have_link(I18n.t('sections.new'),
                                href: new_admins_event_section_path(section.event))
    }

    it {
      expect(page).to have_button(I18n.t('sections.save_order'),
                                  id: 'save-sections-order')
    }
  end
end
