require 'rails_helper'

RSpec.describe Researcher, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:gender) }
    it { is_expected.to validate_presence_of(:institution) }
    it { is_expected.to validate_presence_of(:scholarity) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:institution) }
    it { is_expected.to belong_to(:scholarity) }
  end
end
