require 'test_helper'

class MobileViewControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get regist" do
    get :regist
    assert_response :success
  end

end
