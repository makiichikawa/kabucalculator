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

  test 'GET /api/indicators?symbol=XXXX,XXXX&priceuppervalue=XX' do
    get '/api/indicators?symbol=1234,1235&priceuppervalue=100'
    assert_response :ok
    assert_match '1234', response.body
  end

  test 'GET /api/indicators?myuhat_shortlowervalue=XX&myuhat_shortuppervalue=XX' do
    get '/api/indicators?myuhat_shortlowervalue=0.02937019630282&myuhat_shortuppervalue=0.02937019630284'
    assert_response :ok
    assert_match '1234', response.body
  end

  test 'GET /api/indicators?sigmahat_shortlowervalue=XX&sigmahat_shortuppervalue=XX' do
    get '/api/indicators?sigmahat_shortlowervalue=0.02434354311211&sigmahat_shortuppervalue=0.02434354311218'
    assert_response :ok
    assert_match '1235', response.body
  end

  test 'GET /api/indicators?probability_shortlowervalue=XX&probability_shortuppervalue=XX' do
    get '/api/indicators?probability_shortlowervalue=-0.43978972768291&probability_shortuppervalue=0'
    assert_response :ok
    assert_match '1235', response.body
  end

  test 'GET /api/indicators?sigmahat_mediumlowervalue=XX&sigmahat_mediumuppervalue=XX' do
    get '/api/indicators?sigmahat_mediumlowervalue=0.02434354311215&sigmahat_mediumuppervalue=0.02434354311219'
    assert_response :ok
    assert_match '1234', response.body
  end

  test 'GET /api/indicators?probability_mediumlowervalue=XX&probability_mediumuppervalue=XX' do
    get '/api/indicators?probability_mediumlowervalue=0'
    assert_response :ok
    assert_match '1235', response.body
  end

  test 'GET /api/indicators?myuhat_longlowervalue=XX&myuhat_longuppervalue=XX' do
    get '/api/indicators?myuhat_longlowervalue=0.02937019630281&myuhat_longuppervalue=0.02937019630284'
    assert_response :ok
    assert_match '1234', response.body
    assert_match '1235', response.body
  end

  test 'GET /api/indicators?sigmahat_longlowervalue=XX&sigmahat_longuppervalue=XX' do
    get '/api/indicators?sigmahat_longuppervalue=0.02434354311210'
    assert_response :ok
    assert_no_match '1234', response.body
    assert_no_match '1235', response.body
  end

  test 'GET /api/indicators?probability_longlowervalue=XX&probability_longuppervalue=XX' do
    get '/api/indicators?probability_longlowervalue=-0.43978972768291&probability_longuppervalue=0&priceuppervalue=100'
    assert_response :ok
    assert_no_match '1234', response.body
    assert_no_match '1235', response.body
  end
end
