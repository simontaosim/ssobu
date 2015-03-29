require 'test_helper'

class ProvinceStatesControllerTest < ActionController::TestCase
  setup do
    @province_state = province_states(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:province_states)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create province_state" do
    assert_difference('ProvinceState.count') do
      post :create, province_state: { name: @province_state.name }
    end

    assert_redirected_to province_state_path(assigns(:province_state))
  end

  test "should show province_state" do
    get :show, id: @province_state
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @province_state
    assert_response :success
  end

  test "should update province_state" do
    patch :update, id: @province_state, province_state: { name: @province_state.name }
    assert_redirected_to province_state_path(assigns(:province_state))
  end

  test "should destroy province_state" do
    assert_difference('ProvinceState.count', -1) do
      delete :destroy, id: @province_state
    end

    assert_redirected_to province_states_path
  end
end
