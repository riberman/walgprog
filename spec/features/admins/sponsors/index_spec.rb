require 'rails_helper'

describe 'Admins::Event::index', type: :feature do
  let(:admin) { create(:admin) }
  let!(:event) { create(:event, :with_sponsors) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_event_sponsors_path(event)
  end

  context 'with data' do
    it 'showed' do
      within('table tbody') do
        event.sponsors.each do |sponsor|
          expect(page).to have_content(sponsor.id)
          expect(page).to have_content(sponsor.name)
          expect(page).to have_content(sponsor.acronym)

          expect(page).to have_destroy_link(href: admins_event_sponsor_path(event, sponsor))
        end
      end
    end
  end

  context 'with links' do
    it { expect(page).to have_selector("input[type=submit][value='#{I18n.t('sponsors.add')}']") }
  end
end
