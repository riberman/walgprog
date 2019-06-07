require 'rails_helper'

RSpec.describe SponsorEvent, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:event) }
    it { is_expected.to validate_presence_of(:institution) }
  end

  describe 'associations' do
    let!(:sponsor_event) { create(:sponsor_event) }

    it { is_expected.to belong_to(:event) }
    it { is_expected.to belong_to(:institution) }

    it 'be valid' do
      expect(sponsor_event).to be_valid
    end
  end
end
