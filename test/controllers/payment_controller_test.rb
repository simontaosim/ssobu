require 'test_helper'

class PaymentControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get to_pay" do
    get :to_pay
    assert_response :success
  end

  test "should get pay_success" do
    get :pay_success
    assert_response :success
  end

  test "should get pay_fail" do
    get :pay_fail
    assert_response :success
  end

  test "should get require_pay_back" do
    get :require_pay_back
    assert_response :success
  end

end
