require 'rails_helper'

RSpec.describe Institution, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:acronym) }
    it { is_expected.to validate_presence_of(:city_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:city) }
  end
end
