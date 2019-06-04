RSpec::Matchers.define :have_breadcrumbs do |breadcrumbs, options|
  match do |page|
    @el = page.find(options[:in])
    @options = options
    @breadcrumbs = breadcrumbs

    return false unless expect_links

    expect_last_as_text
  end

  failure_message do
    "expected that page have #{breadcrumbs} in '#{options[:in]}' #{@message}"
  end

  def range
    return 0..-2 if @options[:last]

    0..-1
  end

  def expect_links
    breadcrumbs[range].each do |breadcrumb|
      test = @el.has_link?(breadcrumb[:text], href: breadcrumb[:path])

      unless test
        @message = "bunt not found '#{breadcrumb}' as a link"
        return false
      end
    end
  end

  def expect_last_as_text
    return true unless @options[:last]

    breadcrumb = @breadcrumbs.last
    return false unless expect_not_have_a_link(breadcrumb)

    expect_have_a_text(breadcrumb)
  end

  def expect_not_have_a_link(breadcrumb)
    return true unless @el.has_link?(breadcrumb[:text], href: breadcrumb[:path])

    @message = "the '#{breadcrumb}' should just just have the text but found with link"
    false
  end

  def expect_have_a_text(breadcrumb)
    return true if @el.has_text?(breadcrumb[:text])

    @message = "but not found the '#{breadcrumb[:text]}' as text"
    false
  end
end
