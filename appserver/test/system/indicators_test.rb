# frozen_string_literal: true

require 'application_system_test_case'

class IndicatorsTest < ApplicationSystemTestCase
  test 'show indicators table' do
    visit indicators_path
    assert_selector('th', count: 11)
    assert_selector('td', count: 44)
  end

  test 'execute query of myuhat_medium condition' do
    visit indicators_path
    fill_in 'myuhat-medium-lower-value', with: '-0.02937019630284'
    fill_in 'myuhat-medium-upper-value', with: '-0.02937019630282'
    click_on '絞り込み'
    within('.v-data-table') do
      assert_selector('td', count: 11)
      assert_text '1234'
    end
  end

  test 'execute query of three symbols condition' do
    visit indicators_path
    fill_in 'symbol', with: '1234 1235 1236'
    click_on '絞り込み'
    within('.v-data-table') do
      assert_selector('td', count: 33)
      assert_text '1234'
      assert_text '1235'
      assert_text '1236'
    end
  end
end
