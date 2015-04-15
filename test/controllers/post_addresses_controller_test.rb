require 'test_helper'

class PostAddressesControllerTest < ActionController::TestCase
  setup do
    @post_address = post_addresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:post_addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post_address" do
    assert_difference('PostAddress.count') do
      post :create, post_address: { area_id: @post_address.area_id, city_id: @post_address.city_id, country_id: @post_address.country_id, planet_id: @post_address.planet_id, province_id: @post_address.province_id }
    end

    assert_redirected_to post_address_path(assigns(:post_address))
  end

  test "should show post_address" do
    get :show, id: @post_address
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post_address
    assert_response :success
  end

  test "should update post_address" do
    patch :update, id: @post_address, post_address: { area_id: @post_address.area_id, city_id: @post_address.city_id, country_id: @post_address.country_id, planet_id: @post_address.planet_id, province_id: @post_address.province_id }
    assert_redirected_to post_address_path(assigns(:post_address))
  end

  test "should destroy post_address" do
    assert_difference('PostAddress.count', -1) do
      delete :destroy, id: @post_address
    end

    assert_redirected_to post_addresses_path
  end
end
