require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:state) }
    it { is_expected.to have_many(:institutions).dependent(:restrict_with_error) }
  end
end
