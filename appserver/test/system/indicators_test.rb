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

  test 'validate symbol' do
    visit indicators_path
    fill_in 'symbol', with: '123'
    within('.v-form') do
      assert_text '4桁の整数のみ有効。'
    end
    fill_in 'symbol', with: '1234, 1235'
    within('.v-form') do
      assert_text 'スペースでつなげると複数検索可(1234 1235)'
    end
    click_on '絞り込み'
    within('.v-data-table') do
      assert_selector('td', count: 44)
      assert_text '1234'
      assert_text '1235'
      assert_text '1236'
      assert_text '1237'
    end
  end

  test 'validate price' do
    visit indicators_path
    fill_in 'price-lower-value', with: '-100'
    fill_in 'price-upper-value', with: 'hoge'
    within('.v-form') do
      assert_text '正の数のみ有効'
      assert_text '数値のみ有効'
    end
    fill_in 'myuhat-short-lower-value', with: '0'
    click_on '絞り込み'
    within('.v-data-table') do
      assert_selector('td', count: 44)
      assert_text '1234'
      assert_text '1235'
      assert_text '1236'
      assert_text '1237'
    end
  end

  test 'validate probability' do
    visit indicators_path
    fill_in 'probability-long-lower-value', with: '-100'
    within('.v-form') do
      assert_text '-50～50のみ有効'
    end
    fill_in 'myuhat-medium-lower-value', with: '-0.02'
    click_on '絞り込み'
    within('.v-data-table') do
      assert_selector('td', count: 44)
      assert_text '1234'
      assert_text '1235'
      assert_text '1236'
      assert_text '1237'
    end
  end
end
