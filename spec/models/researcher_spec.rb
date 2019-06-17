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

  describe '.genders' do
    subject(:researcher) { Researcher.new }

    it 'enum' do
      expect(researcher).to define_enum_for(:gender)
        .with_values(male: 'M', female: 'F')
        .backed_by_column_of_type(:string)
        .with_suffix(:gender)
    end

    it 'human enum' do
      hash = { I18n.t('enums.genders.male') => 'male',
               I18n.t('enums.genders.female') => 'female' }

      expect(Researcher.human_genders).to include(hash)
    end
  end
end
