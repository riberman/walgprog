module Helpers
  module Form
    def selectize(name, options = {})
      id = options[:from].include?('_id') ? options[:from] : "#{options[:from]}_id"

      find("\##{id}-selectized").click

      if name.empty?
        find("\##{id}-selectized").native.send_keys(:backspace)
        find("\##{id}-selectized").native.send_keys(:tab)
      else
        find(".#{options[:from]} div.selectize-dropdown-content .option", text: name).click
      end
    end
  end
end
