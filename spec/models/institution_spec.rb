require 'rails_helper'

RSpec.describe Institution, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:acronym) }
    it { is_expected.to validate_presence_of(:city_id) }
    it { is_expected.to validate_presence_of(:approved) }

    it 'virtual attribute state_id' do
      institution = Institution.new

      expect(institution).not_to be_valid
      expect(institution.errors[:state_id]).to include(I18n.t('errors.messages.blank'))
    end
  end

  describe 'associations' do
    let(:institution) { create(:institution) }

    it { is_expected.to belong_to(:city) }
    it { is_expected.to have_many(:contacts).dependent(:restrict_with_error) }

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

  describe '#approved' do
    let(:institution_approved) { build(:institution, :approved) }
    let(:institution_unapproved) { build(:institution, :unapproved) }

    it 'approved' do
      expect(institution_approved.approved).to eq 'yes'
    end

    it 'unapproved' do
      expect(institution_unapproved.approved).to eq 'not'
    end

    it 'approved? equals true' do
      expect(institution_approved.yes_approved?).to be true
      expect(institution_approved.not_approved?).to be false
    end

    it 'approved? equals false' do
      expect(institution_unapproved.not_approved?).to be true
      expect(institution_unapproved.yes_approved?).to be false
    end
  end

  describe '.approved' do
    subject(:institution) { Institution.new }

    it 'enum' do
      expect(institution).to define_enum_for(:approved)
        .with_values(yes: true, not: false)
        .backed_by_column_of_type(:boolean)
        .with_suffix(:approved)
    end

    it 'human enum' do
      hash = { I18n.t('enums.approved.yes') => 'yes',
               I18n.t('enums.approved.not') => 'not' }

      expect(Institution.human_approveds).to include(hash)
    end
  end
end
