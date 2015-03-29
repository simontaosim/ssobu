require 'test_helper'

class ProductIntrosControllerTest < ActionController::TestCase
  setup do
    @product_intro = product_intros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_intros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_intro" do
    assert_difference('ProductIntro.count') do
      post :create, product_intro: {  }
    end

    assert_redirected_to product_intro_path(assigns(:product_intro))
  end

  test "should show product_intro" do
    get :show, id: @product_intro
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_intro
    assert_response :success
  end

  test "should update product_intro" do
    patch :update, id: @product_intro, product_intro: {  }
    assert_redirected_to product_intro_path(assigns(:product_intro))
  end

  test "should destroy product_intro" do
    assert_difference('ProductIntro.count', -1) do
      delete :destroy, id: @product_intro
    end

    assert_redirected_to product_intros_path
  end
end
