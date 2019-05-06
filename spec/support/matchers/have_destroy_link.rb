RSpec::Matchers.define :have_destroy_link do |options|
  match do |page|
    destroy_link = "a[href='#{options[:href]}'][data-method='delete']"
    page.has_css?(destroy_link)
  end

  failure_message do
    "expected that page have destroy link with href '#{options[:href]}'"
  end
end
