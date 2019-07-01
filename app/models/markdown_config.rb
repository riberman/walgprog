class MarkdownConfig
  def extensions
    {
      escape_html: true,
      space_after_headers: true,
      autolink: true
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
