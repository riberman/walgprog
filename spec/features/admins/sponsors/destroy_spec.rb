require 'rails_helper'

describe 'Admins::Event::Sponsor::destroy', type: :feature do
  let(:admin) { create(:admin) }
  let!(:sponsor) { create(:sponsor_event) }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  it 'remove the sponsor of event' do
    visit admins_event_sponsors_path(sponsor.event)

    click_on_destroy_link(admins_event_sponsor_path(sponsor.event,
                                                    sponsor.institution))

    success_message = I18n.t('flash.actions.destroy.m',
                             resource_name: SponsorEvent.model_name.human)

    expect(page).to have_current_path admins_event_sponsors_path(sponsor.event)
    expect(page).to have_flash(:success, text: success_message)

    within('table tbody') do
      expect(page).not_to have_content(sponsor.institution.id)
      expect(page).not_to have_content(sponsor.institution.name)
      expect(page).not_to have_content(sponsor.institution.acronym)
    end
  end
end
