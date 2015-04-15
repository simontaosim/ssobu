require 'test_helper'

class PersonalControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get my_account" do
    get :my_account
    assert_response :success
  end

  test "should get myorder" do
    get :myorder
    assert_response :success
  end

  test "should get account_setting" do
    get :account_setting
    assert_response :success
  end

end
