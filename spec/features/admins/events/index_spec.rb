require 'rails_helper'

describe 'Admins::Event::index', type: :feature do
  let(:admin) { create(:admin) }
  let!(:events) { create_list(:event, 3) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_events_path
  end

  context 'with data' do
    it 'showed' do
      within('table tbody') do
        events.each_with_index do |event, i|
          expect(page).to have_content(event.name)
          expect(page).to have_content(event.initials)

          style = page.find("tr:nth-child(#{i + 1}) td:nth-child(2)")[:style]
          expect(style).to eq("color: #{event.color};")

          expect(page).to have_content(event.beginning_date.formatted)
          expect(page).to have_content(event.end_date.formatted)

          expect(page).to have_content(event.local)
          expect(page).to have_content(I18n.l(event.created_at, format: :short_hour))

          expect(page).to have_link(href: admins_event_path(event))
          expect(page).to have_link(href: edit_admins_event_path(event))
          expect(page).to have_destroy_link(href: admins_event_path(event))
        end
      end
    end
  end

  context 'with links' do
    it { expect(page).to have_link(I18n.t('events.new'), href: new_admins_event_path) }
  end

end

