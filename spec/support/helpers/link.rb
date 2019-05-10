module Helpers
  module Link
    def click_on_destroy_link(url, options = {})
      destroy_link = "a[href='#{url}'][data-method='delete']"
      find(destroy_link).click

      return unless options[:alert]

      alert = page.driver.browser.switch_to.alert
      alert.accept
      sleep 2.seconds
    end
  end
end
