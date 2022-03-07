# frozen_string_literal: true

require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get top page' do
    get root_path
    assert_response :success
  end
end
