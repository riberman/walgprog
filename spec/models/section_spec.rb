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

    it 'parse markdown to html' do
      html = <<-HTML.chomp.strip_heredoc
        <h1>Effugiam erit cinerem tenuere concurrere</h1>

        <h2>Mihi persequar et trementi muris constant tibique</h2>

        <p>Lorem markdownum, abstulerunt preces prima. Ripas et concipit <strong>genuit</strong>.</p>

      HTML

      expect(section.content).to eql(html)
    end

    it 'create description short' do
      short_description = "#{section.content_markdown[0...100].gsub!(/[^0-9A-Za-z]/, ' ')}..."

      expect(section.description_short).to eql(short_description)
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
