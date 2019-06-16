module ApplicationHelper
  def full_title(page_title = '', base_title = 'WAlgProg')
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def bootstrap_class_for(flash_type)
    { success: 'alert-success', error: 'alert-danger', alert: 'alert-warning',
      notice: 'alert-info' }[flash_type.to_sym] || flash_type.to_s
  end

  def markdown_to_html(text)
    config = MarkdownConfig.new

    renderer = Redcarpet::Render::HTML.new(config.options)
    markdown = Redcarpet::Markdown.new(renderer, config.extensions)

    markdown.render(text).html_safe
  end
end
