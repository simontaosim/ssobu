require 'test_helper'

class PublicAccountsControllerTest < ActionController::TestCase
  setup do
    @public_account = public_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:public_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create public_account" do
    assert_difference('PublicAccount.count') do
      post :create, public_account: {  }
    end

    assert_redirected_to public_account_path(assigns(:public_account))
  end

  test "should show public_account" do
    get :show, id: @public_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @public_account
    assert_response :success
  end

  test "should update public_account" do
    patch :update, id: @public_account, public_account: {  }
    assert_redirected_to public_account_path(assigns(:public_account))
  end

  test "should destroy public_account" do
    assert_difference('PublicAccount.count', -1) do
      delete :destroy, id: @public_account
    end

    assert_redirected_to public_accounts_path
  end
end
