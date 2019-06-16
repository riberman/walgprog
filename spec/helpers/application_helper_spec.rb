require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'full title' do
    it 'defaulf' do
      expect(helper.full_title).to eql('WAlgProg')
    end

    it 'title' do
      expect(helper.full_title('Home')).to eql('Home | WAlgProg')
    end
  end

  describe 'flash' do
    it 'success to bootstrap class alert' do
      expect(helper.bootstrap_class_for('success')).to eql('alert-success')
    end
    it 'error to bootstrap class alert' do
      expect(helper.bootstrap_class_for('error')).to eql('alert-danger')
    end
    it 'alert to bootstrap class alert' do
      expect(helper.bootstrap_class_for('alert')).to eql('alert-warning')
    end
    it 'notice to bootstrap class alert' do
      expect(helper.bootstrap_class_for('notice')).to eql('alert-info')
    end
    it 'any other to same bootstrap class alert' do
      expect(helper.bootstrap_class_for('danger')).to eql('danger')
    end
  end

  describe 'markdown' do
    it 'parse markdown to html' do
      markdown = <<-MARKDOWN.strip_heredoc
        # Effugiam erit cinerem tenuere concurrere
        ## Mihi persequar et trementi muris constant tibique
        Lorem markdownum, abstulerunt preces prima. Ripas et concipit **genuit**.
      MARKDOWN

      html = <<-HTML.chomp.strip_heredoc
        <h1>Effugiam erit cinerem tenuere concurrere</h1>

        <h2>Mihi persequar et trementi muris constant tibique</h2>

        <p>Lorem markdownum, abstulerunt preces prima. Ripas et concipit <strong>genuit</strong>.</p>

      HTML

      expect(helper.markdown_to_html(markdown)).to eql(html)
    end
  end
end
