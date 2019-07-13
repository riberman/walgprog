require 'rails_helper'

RSpec.describe Section, type: :model do
  describe 'validates' do
    [:title, :content_md, :icon, :status].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    context 'with status' do
      it 'inactive' do
        section = create(:section, :inactive)
        expect(section.inactive?).to be true
      end

      it 'active' do
        section = create(:section)
        expect(section.active?).to be true
      end

      it 'alternative_content' do
        section = create(:section, :alternative_content)
        expect(section.alternative_content?).to be true
      end

      it 'other without alternative_content' do
        section = build(:section, :alternative_content, alternative_content_md: nil)
        expect(section.valid?).to be false
      end
    end
  end

  describe 'markdown' do
    it 'parse to html' do
      section = create(:section)
      html = <<-HTML.chomp.strip_heredoc
        <h1>Effugiam erit cinerem tenuere concurrere</h1>

        <h2>Mihi persequar et trementi muris constant tibique</h2>

        <p>Lorem markdownum, abstulerunt preces prima. Ripas et concipit <strong>genuit</strong>.</p>

      HTML

      expect(section.content).to eql(html)
      expect(section.alternative_content).to eql(html)
    end
  end

  describe '.statuses' do
    subject(:section) { Section.new }

    it 'enum' do
      expect(section).to define_enum_for(:status)
        .with_values(active: 'active', inactive: 'inactive',
                     alternative_content: 'alternative_content')
        .backed_by_column_of_type(:enum)
    end

    it 'human enum' do
      hash = { I18n.t('enums.section_statuses.active') => 'active',
               I18n.t('enums.section_statuses.inactive') => 'inactive',
               I18n.t('enums.section_statuses.alternative_content') => 'alternative_content' }

      expect(Section.human_statuses).to include(hash)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:event) }
  end
end
