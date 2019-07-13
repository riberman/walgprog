class MarkdownRenders::HTML
  include Singleton
  attr_reader :markdown

  def initialize
    renderer = Redcarpet::Render::HTML.new(options)
    @markdown = Redcarpet::Markdown.new(renderer, extensions)
  end

  def self.render(content)
    MarkdownRenders::HTML.instance.markdown.render(content)
  end

  private

  def extensions
    {
      escape_html: true,
      space_after_headers: true,
      autolink: true,
      tables: true
    }
  end

  def options
    {
      filter_html: false,
      link_attributes: {
        rel: 'nofollow',
        target: 'blank'
      }
    }
  end
end
