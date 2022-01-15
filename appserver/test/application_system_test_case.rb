# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Capybara.default_driver = :selenium_chrome
  Capybara.register_driver :selenium_chrome do |app|
    url = ENV['SELENIUM_DRIVER_URL']
    options = ::Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--window-size=1400,1400')
    Capybara::Selenium::Driver.new(app, browser: :remote, url: url, capabilities: [options])
  end
  driven_by :selenium_chrome
  Capybara.server_host = 'appserver'
  Capybara.app_host = 'http://appserver'
end
