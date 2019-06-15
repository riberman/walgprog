require 'rails_helper'

describe 'Section:show', type: :feature do
  let(:admin) { create(:admin) }
  let(:section) { create(:section) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_event_section_path(section.event, section)
  end

  context 'with data' do
    it 'showed' do
      expect(page).to have_content(I18n.t('sections.show', event: section.event.name))
      expect(page).to have_content(section.title)
      expect(page).to have_content(section.content)
      expect(page).to have_content(I18n.t("enums.status_types.#{section.status}"))
      expect(page).to have_content(section.index)
      expect(page).to have_css "p .fa-#{section.icon}"
      expect(page).to have_content(I18n.l(section.created_at, format: :short))
    end
  end

  context 'with links' do
    it {
      expect(page).to have_link(I18n.t('helpers.edit'),
                                href: edit_admins_event_section_path(section.event, section))
    }
    it {
      expect(page).to have_link(I18n.t('helpers.back'),
                                href: admins_event_sections_path(section.event))
    }
  end
end
