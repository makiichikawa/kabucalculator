# frozen_string_literal: true

require 'application_system_test_case'

class IndicatorsTest < ApplicationSystemTestCase
  test 'show indicators table' do
    visit indicators_path
    assert_selector('th', count: 11)
    assert_selector('td', count: 44)
  end

  test 'show meta title' do
    visit indicators_path
    assert_equal '指標一覧 | KabuCalculator', title
  end

  test 'execute query of myuhat_medium condition' do
    visit indicators_path
    fill_in 'myuhat_medium-lower-value', with: '-0.02937019630284'
    fill_in 'myuhat_medium-upper-value', with: '-0.02937019630282'
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
    fill_in 'myuhat_short-lower-value', with: '0'
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
    fill_in 'probability_long-lower-value', with: '-100'
    within('.v-form') do
      assert_text '-50～50のみ有効'
    end
    fill_in 'myuhat_medium-lower-value', with: '-0.02'
    click_on '絞り込み'
    within('.v-data-table') do
      assert_selector('td', count: 44)
      assert_text '1234'
      assert_text '1235'
      assert_text '1236'
      assert_text '1237'
    end
  end

  test 'show indicators graph' do
    visit indicators_path
    click_on 'グラフでみる'
    within('#graph-items') do
      assert_text '短期上昇率・下降率'
      assert_text '短期リターン'
      assert_text '短期リスク'
      assert_text '中期上昇率・下降率'
      assert_text '中期リターン'
      assert_text '中期リスク'
      assert_text '長期上昇率・下降率'
      assert_text '長期リターン'
      assert_text '長期リスク'
    end
  end

  test 'validate graph items' do
    visit indicators_path
    click_on 'グラフでみる'
    within('#graph-items') do
      find('label', text: '中期リターン', match: :first).click
      assert_text '指標はふたつのみ有効'
    end
  end

  test 'show additionals page' do
    visit additionals_path
    assert_equal '補足説明 | KabuCalculator', title
  end

  test 'show additionals page when click on indicators item' do
    visit indicators_path
    click_on '短期リターン'
    assert_equal '補足説明 | KabuCalculator', title
  end

  test 'show indicators page when click on back button' do
    visit additionals_path
    click_on '戻る'
    assert_equal '指標一覧 | KabuCalculator', title
  end
end
