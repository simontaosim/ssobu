require 'test_helper'

class PersonalCenterControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get my_commission" do
    get :my_commission
    assert_response :success
  end

  test "should get apply_cash" do
    get :apply_cash
    assert_response :success
  end

end
