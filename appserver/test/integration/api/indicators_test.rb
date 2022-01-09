# frozen_string_literal: true

require 'test_helper'

class Api::IndicatorsTest < ActionDispatch::IntegrationTest
  fixtures :indicators

  test 'GET /api/indicators.json' do
    get api_indicators_path
    assert_response :ok
    assert_match '1234', response.body
    assert_match '1235', response.body
  end
end
