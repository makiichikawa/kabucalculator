# frozen_string_literal: true

require 'test_helper'

class IndicatorTest < ActiveSupport::TestCase
  test '#round' do
    indicators = indicators(:kabu_a)
    expected = {
      'symbol' => '1234',
      'price' => 100,
      'probability_short' => -0.4398,
      'myuhat_short' => 0.0294,
      'sigmahat_short' => 0.0243,
      'probability_medium' => 0.4398,
      'myuhat_medium' => -0.0294,
      'sigmahat_medium' => 0.0243,
      'probability_long' => -0.4398,
      'myuhat_long' => 0.0294,
      'sigmahat_long' => 0.0243
    }
    assert_equal expected, indicators.round
  end
  test 'scope#filter_by_symbols' do
    symbols_array = %w[1234 1235]
    actual_indicators = Indicator.filter_by_symbols(symbols_array)
    assert_equal symbols_array, actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_symbols_in_case_of_nil' do
    actual_indicators = Indicator.filter_by_symbols(nil)
    assert_equal %w[1234 1235 1236 1237], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_price_in_case_of_both_value_filled' do
    actual_indicators = Indicator.filter_by_price(100, 102)
    assert_equal %w[1234 1235 1236], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_price_in_case_of_lower_value_nil' do
    actual_indicators = Indicator.filter_by_price(nil, 100)
    assert_equal ['1234'], actual_indicators.pluck(:symbol)
  end
  test 'scope#filter_by_price_in_case_of_both_value_nil' do
    actual_indicators = Indicator.filter_by_price(nil, nil)
    assert_equal %w[1234 1235 1236 1237], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_myuhat_short_in_case_of_both_value_filled' do
    actual_indicators = Indicator.filter_by_myuhat_short(0.01, 0.03)
    assert_equal %w[1234 1235 1237], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_myuhat_short_in_case_of_lower_value_nil' do
    actual_indicators = Indicator.filter_by_myuhat_short(nil, 0)
    assert_equal ['1236'], actual_indicators.pluck(:symbol)
  end
  test 'scope#filter_by_myuhat_short_in_case_of_both_value_nil' do
    actual_indicators = Indicator.filter_by_myuhat_short(nil, nil)
    assert_equal %w[1234 1235 1236 1237], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_sigmahat_short_in_case_of_both_value_filled' do
    actual_indicators = Indicator.filter_by_sigmahat_short(0.02, 0.03)
    assert_equal %w[1234 1235 1236], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_sigmahat_short_in_case_of_lower_value_nil' do
    actual_indicators = Indicator.filter_by_sigmahat_short(nil, 0.02)
    assert_equal ['1237'], actual_indicators.pluck(:symbol)
  end
  test 'scope#filter_by_sigmahat_short_in_case_of_both_value_nil' do
    actual_indicators = Indicator.filter_by_sigmahat_short(nil, nil)
    assert_equal %w[1234 1235 1236 1237], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_probability_short_in_case_of_both_value_filled' do
    actual_indicators = Indicator.filter_by_probability_short(-0.5, -0.2)
    assert_equal %w[1234 1235 1236], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_probability_short_in_case_of_upper_value_nil' do
    actual_indicators = Indicator.filter_by_probability_short(-0.2, nil)
    assert_equal ['1237'], actual_indicators.pluck(:symbol)
  end
  test 'scope#filter_by_probability_short_in_case_of_both_value_nil' do
    actual_indicators = Indicator.filter_by_probability_short(nil, nil)
    assert_equal %w[1234 1235 1236 1237], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_myuhat_medium_in_case_of_both_value_filled' do
    actual_indicators = Indicator.filter_by_myuhat_medium(-0.03, -0.02)
    assert_equal %w[1234 1235 1236], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_myuhat_medium_in_case_of_lower_value_nil' do
    actual_indicators = Indicator.filter_by_myuhat_medium(nil, 0)
    assert_equal %w[1234 1235 1236 1237], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_myuhat_medium_in_case_of_both_value_nil' do
    actual_indicators = Indicator.filter_by_myuhat_medium(nil, nil)
    assert_equal %w[1234 1235 1236 1237], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_sigmahat_medium_in_case_of_both_value_filled' do
    actual_indicators = Indicator.filter_by_sigmahat_medium(0.02, 0.03)
    assert_equal %w[1234 1235 1236], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_sigmahat_medium_in_case_of_lower_value_nil' do
    actual_indicators = Indicator.filter_by_sigmahat_medium(nil, 0.02)
    assert_equal ['1237'], actual_indicators.pluck(:symbol)
  end
  test 'scope#filter_by_sigmahat_medium_in_case_of_both_value_nil' do
    actual_indicators = Indicator.filter_by_sigmahat_medium(nil, nil)
    assert_equal %w[1234 1235 1236 1237], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_probability_medium_in_case_of_both_value_filled' do
    actual_indicators = Indicator.filter_by_probability_medium(-0.5, -0.2)
    assert_equal ['1236'], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_probability_medium_in_case_of_upper_value_nil' do
    actual_indicators = Indicator.filter_by_probability_medium(-0.2, nil)
    assert_equal %w[1234 1235 1237], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_probability_medium_in_case_of_both_value_nil' do
    actual_indicators = Indicator.filter_by_probability_medium(nil, nil)
    assert_equal %w[1234 1235 1236 1237], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_myuhat_long_in_case_of_both_value_filled' do
    actual_indicators = Indicator.filter_by_myuhat_long(-0.03, -0.02)
    assert_equal ['1236'], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_myuhat_long_in_case_of_lower_value_nil' do
    actual_indicators = Indicator.filter_by_myuhat_long(0, nil)
    assert_equal %w[1234 1235 1237], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_myuhat_long_in_case_of_both_value_nil' do
    actual_indicators = Indicator.filter_by_myuhat_long(nil, nil)
    assert_equal %w[1234 1235 1236 1237], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_sigmahat_long_in_case_of_both_value_filled' do
    actual_indicators = Indicator.filter_by_sigmahat_long(0.02, 0.03)
    assert_equal %w[1234 1235 1236], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_sigmahat_long_in_case_of_lower_value_nil' do
    actual_indicators = Indicator.filter_by_sigmahat_long(nil, 0.02)
    assert_equal ['1237'], actual_indicators.pluck(:symbol)
  end
  test 'scope#filter_by_sigmahat_long_in_case_of_both_value_nil' do
    actual_indicators = Indicator.filter_by_sigmahat_long(nil, nil)
    assert_equal %w[1234 1235 1236 1237], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_probability_long_in_case_of_both_value_filled' do
    actual_indicators = Indicator.filter_by_probability_long(-0.5, -0.2)
    assert_equal %w[1234 1235 1236], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_probability_long_in_case_of_upper_value_nil' do
    actual_indicators = Indicator.filter_by_probability_long(-0.2, nil)
    assert_equal ['1237'], actual_indicators.pluck(:symbol).sort
  end
  test 'scope#filter_by_probability_long_in_case_of_both_value_nil' do
    actual_indicators = Indicator.filter_by_probability_long(nil, nil)
    assert_equal %w[1234 1235 1236 1237], actual_indicators.pluck(:symbol).sort
  end
end
