require 'rails_helper'

describe 'Admins::Section::destroy', type: :feature do
  let(:admin) { create(:admin) }
  let!(:section) { create(:section) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_event_sections_path(section.event)
  end

  it 'delete the section' do
    event = section.event
    click_on_destroy_link(admins_event_section_path(event, section))

    expect(page).to have_current_path admins_event_sections_path(event)

    success_message = I18n.t('flash.actions.destroy.f', resource_name: Section.model_name.human)
    expect(page).to have_flash(:success, text: success_message)

    within('table tbody') do
      expect(page).not_to have_content(section.title)
    end
  end
end
