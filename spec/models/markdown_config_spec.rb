require 'rails_helper'

RSpec.describe MarkdownConfig, type: :Class do
  describe 'Configuration' do
    let!(:config) { MarkdownConfig.new }

    it 'get options' do
      options = {
        filter_html: false,
        link_attributes: {
          rel: 'nofollow',
          target: 'blank'
        }
      }
      expect(config.options).to eql(options)
    end

    it 'get extension' do
      extensions = {
        espcape_html: true,
        space_after_headers: true,
        autolink: true
      }
      expect(config.extensions).to eql(extensions)
    end
  end
end
