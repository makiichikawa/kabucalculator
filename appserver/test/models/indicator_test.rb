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
end
