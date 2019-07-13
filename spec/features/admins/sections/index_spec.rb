require 'rails_helper'

describe 'Admins::Section::index', type: :feature do
  let(:admin) { create(:admin) }
  let!(:event) { create(:event, :with_sections) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_event_sections_path(event)
  end

  context 'with data' do
    it 'showed' do
      within('table tbody') do
        event.sections.each_with_index do |section, i|
          within("tr:nth-child(#{i + 1})") do
            icon_class = page.find('td:nth-child(2) i')[:class]
            expect(icon_class).to eq(section.icon)

            expect(page).to have_content(section.title)
            expect(page).to have_content(I18n.t("enums.section_statuses.#{section.status}"))
            expect(page).to have_content(I18n.l(section.created_at, format: :short))

            expect(page).to have_link(href: admins_event_section_path(event, section))
            expect(page).to have_link(href: edit_admins_event_section_path(event, section))
            expect(page).to have_destroy_link(href: admins_event_section_path(event, section))
          end
        end
      end
    end
  end

  context 'with links' do
    it do
      expect(page).to have_link(I18n.t('sections.new'),
                                href: new_admins_event_section_path(event))
    end
  end
end
