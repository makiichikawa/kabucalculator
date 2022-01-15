# frozen_string_literal: true

require 'application_system_test_case'

class IndicatorsTest < ApplicationSystemTestCase
  test 'show indicators table' do
    visit indicators_path
    assert_selector('th', count: 11)
    assert_selector('td', count: 22)
  end
end
