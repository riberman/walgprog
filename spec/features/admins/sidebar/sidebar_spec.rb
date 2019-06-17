require 'rails_helper'

describe 'Admins::Sidebar', type: :feature do
  let(:admin) { create(:admin) }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  context 'when enter in Event' do
    let!(:event) { create(:event) }

    it 'to show' do
      visit admins_event_path(event)

      element = page.find('#sidebarMenuCollapse')
      expect(element).to have_content(I18n.t('events.show'))
      expect(element).to have_content(I18n.t('sponsors.index'))
    end
  end
end
