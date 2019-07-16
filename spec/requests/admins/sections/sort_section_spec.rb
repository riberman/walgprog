require 'rails_helper'

describe 'Admins::Section::sort', type: :request do
  let(:resource_name) { Section.model_name.human }
  let(:admin) { create(:admin) }
  let!(:event) { create(:event, :with_sections) }

  before(:each) do
    login_as(admin, scope: :admin)
    admins_event_sections_path(event)
  end

  describe 'update position' do
    it 'when success' do
      params = { section: [], event_id: event.id }
      params[:section] = event.sections.reverse.map(&:id)

      patch "/admins/events/#{event.id}/sections/sort", params: params
      expect(response).to have_http_status(:accepted)

      event.reload
      expect(event.sections.order(position: :asc).map(&:id)).to eq(params[:section])
    end
  end
end
