# frozen_string_literal: true

require 'test_helper'

class IndicatorTest < ActiveSupport::TestCase
  setup do
    @price = { lower: nil, upper: nil }
    @myuhat = {
      short: { lower: nil, upper: nil },
      medium: { lower: nil, upper: nil },
      long: { lower: nil, upper: nil }
    }
    @sigmahat = {
      short: { lower: nil, upper: nil },
      medium: { lower: nil, upper: nil },
      long: { lower: nil, upper: nil }
    }
    @probability = {
      short: { lower: nil, upper: nil },
      medium: { lower: nil, upper: nil },
      long: { lower: nil, upper: nil }
    }
  end

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
    @price[:lower] = 100
    @price[:upper] = 102
    actual_indicators = Indicator.filter_by_price(@price)
    assert_equal %w[1234 1235 1236], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by_price_in_case_of_lower_value_nil' do
    @price[:upper] = 100
    actual_indicators = Indicator.filter_by_price(@price)
    assert_equal ['1234'], actual_indicators.pluck(:symbol)
  end

  test 'scope#filter_by_price_in_case_of_both_value_nil' do
    actual_indicators = Indicator.filter_by_price(@price)
    assert_equal %w[1234 1235 1236 1237], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by_myuhat_short_in_case_of_both_value_filled' do
    @myuhat[:short][:lower] = 0.01
    @myuhat[:short][:upper] = 0.03
    actual_indicators = Indicator.filter_by_myuhat(@myuhat)
    assert_equal %w[1234 1235 1237], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by_@myuhat_short_in_case_of_lower_value_nil' do
    @myuhat[:short][:upper] = 0
    actual_indicators = Indicator.filter_by_myuhat(@myuhat)
    assert_equal ['1236'], actual_indicators.pluck(:symbol)
  end

  test 'scope#filter_by_myuhat_in_case_of_all_value_nil' do
    actual_indicators = Indicator.filter_by_myuhat(@myuhat)
    assert_equal %w[1234 1235 1236 1237], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by_sigmahat_short_in_case_of_both_value_filled' do
    @sigmahat[:short][:lower] = 0.02
    @sigmahat[:short][:upper] = 0.03
    actual_indicators = Indicator.filter_by_sigmahat(@sigmahat)
    assert_equal %w[1234 1235 1236], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by_sigmahat_short_in_case_of_lower_value_nil' do
    @sigmahat[:short][:upper] = 0.02
    actual_indicators = Indicator.filter_by_sigmahat(@sigmahat)
    assert_equal ['1237'], actual_indicators.pluck(:symbol)
  end

  test 'scope#filter_by_sigmahat_in_case_of_all_value_nil' do
    actual_indicators = Indicator.filter_by_sigmahat(@sigmahat)
    assert_equal %w[1234 1235 1236 1237], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by_probability_short_in_case_of_both_value_filled' do
    @probability[:short][:lower] = -0.5
    @probability[:short][:upper] = -0.2
    actual_indicators = Indicator.filter_by_probability(@probability)
    assert_equal %w[1234 1235 1236], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by_probability_short_in_case_of_upper_value_nil' do
    @probability[:short][:lower] = -0.2
    actual_indicators = Indicator.filter_by_probability(@probability)
    assert_equal ['1237'], actual_indicators.pluck(:symbol)
  end

  test 'scope#filter_by_probability_in_case_of_all_value_nil' do
    actual_indicators = Indicator.filter_by_probability(@probability)
    assert_equal %w[1234 1235 1236 1237], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by_myuhat_medium_in_case_of_both_value_filled' do
    @myuhat[:medium][:lower] = -0.03
    @myuhat[:medium][:upper] = -0.02
    actual_indicators = Indicator.filter_by_myuhat(@myuhat)
    assert_equal %w[1234 1235 1236], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by_myuhat_medium_in_case_of_lower_value_nil' do
    @myuhat[:medium][:upper] = 0
    actual_indicators = Indicator.filter_by_myuhat(@myuhat)
    assert_equal %w[1234 1235 1236 1237], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by_sigmahat_medium_in_case_of_both_value_filled' do
    @sigmahat[:medium][:lower] = 0.02
    @sigmahat[:medium][:upper] = 0.03
    actual_indicators = Indicator.filter_by_sigmahat(@sigmahat)
    assert_equal %w[1234 1235 1236], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by_sigmahat_medium_in_case_of_lower_value_nil' do
    @sigmahat[:medium][:upper] = 0.02
    actual_indicators = Indicator.filter_by_sigmahat(@sigmahat)
    assert_equal ['1237'], actual_indicators.pluck(:symbol)
  end

  test 'scope#filter_by_probability_medium_in_case_of_both_value_filled' do
    @probability[:medium][:lower] = -0.5
    @probability[:medium][:upper] = -0.2
    actual_indicators = Indicator.filter_by_probability(@probability)
    assert_equal ['1236'], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by_probability_medium_in_case_of_upper_value_nil' do
    @probability[:medium][:lower] = -0.2
    actual_indicators = Indicator.filter_by_probability(@probability)
    assert_equal %w[1234 1235 1237], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by_myuhat_long_in_case_of_both_value_filled' do
    @myuhat[:long][:lower] = -0.03
    @myuhat[:long][:upper] = -0.02
    actual_indicators = Indicator.filter_by_myuhat(@myuhat)
    assert_equal ['1236'], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by_myuhat_long_in_case_of_lower_value_nil' do
    @myuhat[:long][:lower] = 0
    actual_indicators = Indicator.filter_by_myuhat(@myuhat)
    assert_equal %w[1234 1235 1237], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by_sigmahat_long_in_case_of_both_value_filled' do
    @sigmahat[:long][:lower] = 0.02
    @sigmahat[:long][:upper] = 0.03
    actual_indicators = Indicator.filter_by_sigmahat(@sigmahat)
    assert_equal %w[1234 1235 1236], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by_sigmahat_long_in_case_of_lower_value_nil' do
    @sigmahat[:long][:upper] = 0.02
    actual_indicators = Indicator.filter_by_sigmahat(@sigmahat)
    assert_equal ['1237'], actual_indicators.pluck(:symbol)
  end

  test 'scope#filter_by_probability_long_in_case_of_both_value_filled' do
    @probability[:long][:lower] = -0.5
    @probability[:long][:upper] = -0.2
    actual_indicators = Indicator.filter_by_probability(@probability)
    assert_equal %w[1234 1235 1236], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by_probability_long_in_case_of_upper_value_nil' do
    @probability[:long][:lower] = -0.2
    actual_indicators = Indicator.filter_by_probability(@probability)
    assert_equal ['1237'], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by_nil' do
    actual_indicators = Indicator.filter_by(nil, @price, @probability, @myuhat, @sigmahat)
    assert_equal %w[1234 1235 1236 1237], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by(symbols=XXXX,XXXX&price_uppervalue=XX)' do
    symbols = %w[1234 1235]
    @price[:upper] = 100
    actual_indicators = Indicator.filter_by(symbols, @price, @probability, @myuhat, @sigmahat)
    assert_equal ['1234'], actual_indicators.pluck(:symbol).sort
  end

  test 'scope#filter_by(probability&&myuhat&&sigmahat)' do
    @probability[:long][:lower] = -0.5
    @probability[:long][:upper] = -0.2
    @sigmahat[:medium][:upper] = 0.02
    @myuhat[:short][:lower] = 0.01
    @myuhat[:short][:upper] = 0.03
    actual_indicators = Indicator.filter_by(nil, @price, @probability, @myuhat, @sigmahat)
    assert_equal [], actual_indicators.pluck(:symbol).sort
  end
end
