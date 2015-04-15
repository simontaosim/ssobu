require 'test_helper'

class ErrorReportControllerTest < ActionController::TestCase
  test "should get with404" do
    get :with404
    assert_response :success
  end

  test "should get with500" do
    get :with500
    assert_response :success
  end

  test "should get with422" do
    get :with422
    assert_response :success
  end

end
