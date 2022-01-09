# frozen_string_literal: true

require 'test_helper'

class IndicatorsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get indicators_path
    assert_response :success
  end
end
