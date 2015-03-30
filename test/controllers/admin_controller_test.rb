require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get product_admin" do
    get :product_admin
    assert_response :success
  end

  test "should get users_admin" do
    get :users_admin
    assert_response :success
  end

  test "should get order_admin" do
    get :order_admin
    assert_response :success
  end

  test "should get address_admin" do
    get :address_admin
    assert_response :success
  end

  test "should get role_admin" do
    get :role_admin
    assert_response :success
  end

  test "should get node_admin" do
    get :node_admin
    assert_response :success
  end

end
