require 'rails_helper'

RSpec.describe State, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_presence_of(:acronym) }
    it { is_expected.to validate_uniqueness_of(:acronym).case_insensitive }
  end

  describe 'associations' do
    it { is_expected.to have_many(:cities).dependent(:destroy) }
    it { is_expected.to belong_to(:region) }
  end
end
