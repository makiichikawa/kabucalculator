# frozen_string_literal: true

require 'application_system_test_case'

class WelcomeTest < ApplicationSystemTestCase
  test 'show top page' do
    visit root_path
    assert_equal 'KabuCalculator', title
  end

  test 'show terms of sevice page' do
    visit tos_path
    assert_equal '利用規約 | KabuCalculator', title
  end

  test 'show terms of sevice page when click footer tos link' do
    visit root_path
    click_on '利用規約'
    assert_equal '利用規約 | KabuCalculator', title
  end
end
