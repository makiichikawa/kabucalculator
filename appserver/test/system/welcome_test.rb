require 'application_system_test_case'

class WelcomeTest < ApplicationSystemTestCase
  test 'show top page' do
    visit root_path
     assert_equal 'KabuCalculator', title
  end
end