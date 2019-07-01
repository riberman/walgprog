require 'rails_helper'

describe 'Admins::Section::destroy', type: :request do
  let(:resource_name) { Section.model_name.human }
  let(:admin) { create(:admin) }
  let!(:event) { create(:event, :with_sections) }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe 'not destroy default section' do
    it 'when success' do
      section = event.sections.first

      delete "/admins/events/#{event.id}/sections/#{section.id}"

      follow_redirect!

      expect(response.body).to include(I18n.t('sections.error.be_deleted'))
    end
  end
end
