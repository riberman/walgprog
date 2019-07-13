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
      within('.card-header') do
        expect(page).to have_content(I18n.t('sections.show', event: section.event.name))
      end

      within('.card-body') do
        expect(page).to have_content(section.position)
        icon_class = page.find('fieldset:first .row div:nth-child(2) i')[:class]
        expect(icon_class).to eq(section.icon)
        expect(page).to have_content(section.title)
        expect(page).to have_content(I18n.t("enums.section_statuses.#{section.status}"))
        expect(page).to have_content(I18n.l(section.created_at, format: :short))

        expect(page.body).to include(section.content)
        expect(page.body).to include(section.alternative_content)
      end
    end
  end

  context 'with links' do
    it do
      expect(page).to have_link(I18n.t('helpers.edit'),
                                href: edit_admins_event_section_path(section.event, section))
    end
    it do
      expect(page).to have_link(I18n.t('helpers.back'),
                                href: admins_event_sections_path(section.event))
    end
  end
end
