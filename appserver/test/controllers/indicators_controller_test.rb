# frozen_string_literal: true

require 'test_helper'

class IndicatorsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get indicators_path
    assert_response :success
    assert_select 'tbody' do
      assert_select 'tr', 2
      assert_select 'tr>td', text: '1234'
    end
  end
end
