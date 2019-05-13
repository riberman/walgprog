module Helpers
  module Form
    def selectize(name, options = {})
      id = normalize_selector(options[:from])

      find("\##{id}-selectized").click

      if name.empty?
        find("\##{id}-selectized").native.send_keys(:backspace)
        find("\##{id}-selectized").native.send_keys(:tab)
      else
        find(".#{options[:from]} div.selectize-dropdown-content .option", text: name).click
      end
    end

    private

    # This is necessary when is used f.association
    def normalize_selector(selector)
      return selector if selector.include?('_id')

      "#{selector}_id"
    end
  end
end
