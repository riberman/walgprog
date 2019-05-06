module Helpers
  module Form
    def selectize(name, options = {})
      find("\##{options[:from]}-selectized").click

      if name.empty?
        find("\##{options[:from]}-selectized").native.send_keys(:backspace)
      else
        find(".#{options[:from]} div.selectize-dropdown-content .option", text: name).click
      end
    end
  end
end
