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

  test 'GET /api/indicators?symbol=XXXX' do
    get '/api/indicators?symbol=1234'
    assert_response :ok
    assert_match '1234', response.body
  end

  test 'GET /api/indicators?symbol=XXXX,XXXX' do
    get '/api/indicators?symbol=1234,1235'
    assert_response :ok
    assert_match '1234', response.body
    assert_match '1235', response.body
  end

  test 'GET /api/indicators?symbol=XXXX,XXXX&price_uppervalue=XX' do
    get '/api/indicators?symbol=1234,1235&price_uppervalue=100'
    assert_response :ok
    assert_match '1234', response.body
  end

  test 'GET /api/indicators?myuhat_short_lowervalue=XX&myuhat_short_uppervalue=XX' do
    get '/api/indicators?myuhat_short_lowervalue=0.02937019630282&myuhat_short_uppervalue=0.02937019630284'
    assert_response :ok
    assert_match '1234', response.body
  end

  test 'GET /api/indicators?sigmahat_short_lowervalue=XX&sigmahat_short_uppervalue=XX' do
    get '/api/indicators?sigmahat_short_lowervalue=0.02434354311211&sigmahat_short_uppervalue=0.02434354311218'
    assert_response :ok
    assert_match '1235', response.body
  end

  test 'GET /api/indicators?probability_short_lowervalue=XX&probability_short_uppervalue=XX' do
    get '/api/indicators?probability_short_lowervalue=-0.43978972768291&probability_short_uppervalue=0'
    assert_response :ok
    assert_match '1235', response.body
  end

  test 'GET /api/indicators?sigmahat_medium_lowervalue=XX&sigmahat_medium_uppervalue=XX' do
    get '/api/indicators?sigmahat_medium_lowervalue=0.02434354311215&sigmahat_medium_uppervalue=0.02434354311219'
    assert_response :ok
    assert_match '1234', response.body
  end

  test 'GET /api/indicators?probability_medium_lowervalue=XX&probability_medium_uppervalue=XX' do
    get '/api/indicators?probability_medium_lowervalue=0'
    assert_response :ok
    assert_match '1235', response.body
  end

  test 'GET /api/indicators?myuhat_long_lowervalue=XX&myuhat_long_uppervalue=XX' do
    get '/api/indicators?myuhat_long_lowervalue=0.02937019630281&myuhat_long_uppervalue=0.02937019630284'
    assert_response :ok
    assert_match '1234', response.body
    assert_match '1235', response.body
  end

  test 'GET /api/indicators?sigmahat_long_lowervalue=XX&sigmahat_long_uppervalue=XX' do
    get '/api/indicators?sigmahat_long_uppervalue=0.02434354311210'
    assert_response :ok
    assert_no_match '1234', response.body
    assert_no_match '1235', response.body
  end

  test 'GET /api/indicators?probability_long_lowervalue=XX&probability_long_uppervalue=XX' do
    get '/api/indicators?probability_long_lowervalue=-0.43978972768291&probability_long_uppervalue=0&price_uppervalue=100'
    assert_response :ok
    assert_no_match '1234', response.body
    assert_no_match '1235', response.body
  end
end
