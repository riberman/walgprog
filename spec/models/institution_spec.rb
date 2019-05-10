require 'rails_helper'

RSpec.describe Institution, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:city) }
    it { is_expected.to have_many(:contacts).dependent(:restrict_with_error) }
  end
end
