class MarkdownConfig

  def extensions
    extensions = {
      space_after_headers: true,
      autolink: true
    }
  end

  def options
    options = {
      filter_html: false,
      link_attributes: {
        rel: 'nofollow',
        target: 'blank'
      }
    }
  end
end