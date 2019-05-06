require 'rails_helper'

RSpec.describe Institution, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:acronym) }
    it { is_expected.to validate_presence_of(:city_id) }

    it 'virtual attribute state_id' do
      institution = Institution.new

      expect(institution).not_to be_valid
      expect(institution.errors[:state_id]).to include(I18n.t('errors.messages.blank'))
    end
  end

  describe 'associations' do
    let(:institution) { create(:institution) }

    it { is_expected.to belong_to(:city) }

    context 'with state' do
      it 'respond a state and state_id by city' do
        expect(institution.state).to eq(institution.city.state)
        expect(institution.state_id).to eq(institution.city.state.id)
      end

      it 'respond a state if has no city' do
        state = create(:state)

        institution.city = nil
        institution.state_id = state.id

        expect(institution.state).to eq(state)
      end

      it 'respond with state_id by city' do
        expect(institution.state_id).to eq(institution.city.state.id)
      end

      it 'respond state_id if has no city' do
        institution.city = nil
        institution.state_id = 10

        expect(institution.state_id).to eq(10)
      end
    end
  end
end
