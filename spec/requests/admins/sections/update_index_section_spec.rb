require 'rails_helper'

describe 'Admins::Section::update', type: :request do
  let(:resource_name) { Section.model_name.human }
  let(:admin) { create(:admin) }
  let!(:event) { create(:event, :with_sections) }

  before(:each) do
    login_as(admin, scope: :admin)
    admins_event_sections_path(event)
  end

  describe 'Update position section', js: true do
    it 'when success' do
      sections = event.sections

      params = sections.map do |section|
        { id: section.id, index: section.index }
      end

      post "/admins/events/#{event.id}/sections/index", params: { list: params, format: :json }
      expect(response.body).to include(I18n.t('sections.saved_order'))
      expect(response).to have_http_status(:accepted)
    end

    it 'when fail' do
      post "/admins/events/#{event.id}/sections/index", params: { format: :json }
      expect(response.body).to include(I18n.t('sections.error.error_order'))
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
