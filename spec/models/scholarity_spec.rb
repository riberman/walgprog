spec/models/researcher_spec.rb
require 'rails_helper'

RSpec.describe Scholarity, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:abbr) }
  end
end
