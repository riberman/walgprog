require 'rails_helper'

RSpec.describe Section, type: :model do
  describe 'before save executing methods' do
    let!(:section) { create(:section) }

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
  end
end
