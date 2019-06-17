require 'rails_helper'

describe 'Admins::Event:show', type: :feature do
  let(:admin) { create(:admin) }
  let(:event) { create(:event) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_event_path(event)
  end

  context 'with data' do
    it 'showed' do
      expect(page).to have_content(event.name)
      expect(page).to have_content(event.initials)

      style = page.find('#event_color .fas.fa-circle')[:style]
      expect(style).to eq("color: #{event.color};")

      expect(page).to have_content(I18n.l(event.beginning_date.to_date, format: :long))
      expect(page).to have_content(I18n.l(event.end_date.to_date, format: :long))

      expect(page).to have_content(event.local)
      expect(page).to have_content(I18n.l(event.created_at, format: :long))
    end
  end

  context 'with links' do
    it { expect(page).to have_link(I18n.t('helpers.edit'), href: edit_admins_event_path(event)) }
    it { expect(page).to have_link(I18n.t('helpers.back'), href: admins_events_path) }
  end
end
