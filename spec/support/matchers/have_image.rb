RSpec::Matchers.define :have_image do |src|
  match do |page|
    page.has_css?("img[src*='#{src}']")
  end
  failure_message do
    "expected that page have image with src '#{src}' but no one was found"
  end
end

RSpec::Matchers.define :have_background_image do |src|
  match do |page|
    page.has_css?("div[style*=\"background-image: url('#{src}')\"]")
  end
  failure_message do
    "expected that page have background image using style with src '#{src}' but no one was found"
  end
end
