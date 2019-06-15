require 'rails_helper'

RSpec.describe Section, type: :model do
  describe 'validates' do
    [:title,
     :content,
     :icon,
     :index,
     :status].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    context 'with status' do
      it 'inactive' do
        section = create(:section, :inactive)
        expect(section.inactive?).to be true
        expect(section).to be_valid
      end

      it 'active' do
        section = create(:section)
        expect(section.active?).to be true
        expect(section).to be_valid
      end

      it 'other' do
        section = create(:section, :other)
        expect(section.other?).to be true
        expect(section).to be_valid
      end

      it 'other without alternative_text' do
        section = create(:section, :other)
        section.alternative_text = nil
        expect(section).not_to be_valid
      end
    end
  end

  describe '.status_types' do
    subject(:section) { Section.new }

    it 'human enum' do
      hash = { I18n.t('enums.status_types.active') => 'active',
               I18n.t('enums.status_types.inactive') => 'inactive',
               I18n.t('enums.status_types.other') => 'other' }

      expect(Section.human_status_types).to include(hash)
    end
  end

  describe 'associations' do
    let(:section) { create(:section) }

    it { is_expected.to belong_to(:event) }
  end
end
