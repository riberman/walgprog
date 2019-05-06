RSpec::Matchers.define :have_selectize do |type, options|
  match do |page|
    page.find(".#{type} .selectize-input .item").has_content?(options[:selected])
  end
  failure_message do
    "expected that page have selectize #{type} with '#{options[:selected]}' selected"
  end
end
