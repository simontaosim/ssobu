require 'test_helper'

class MobileTextsControllerTest < ActionController::TestCase
  setup do
    @mobile_text = mobile_texts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mobile_texts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mobile_text" do
    assert_difference('MobileText.count') do
      post :create, mobile_text: { content: @mobile_text.content, extcode: @mobile_text.extcode, mobile: @mobile_text.mobile, msgid: @mobile_text.msgid, msgtype: @mobile_text.msgtype, scode: @mobile_text.scode, sendtime: @mobile_text.sendtime, signtag: @mobile_text.signtag, temid: @mobile_text.temid, username: @mobile_text.username }
    end

    assert_redirected_to mobile_text_path(assigns(:mobile_text))
  end

  test "should show mobile_text" do
    get :show, id: @mobile_text
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mobile_text
    assert_response :success
  end

  test "should update mobile_text" do
    patch :update, id: @mobile_text, mobile_text: { content: @mobile_text.content, extcode: @mobile_text.extcode, mobile: @mobile_text.mobile, msgid: @mobile_text.msgid, msgtype: @mobile_text.msgtype, scode: @mobile_text.scode, sendtime: @mobile_text.sendtime, signtag: @mobile_text.signtag, temid: @mobile_text.temid, username: @mobile_text.username }
    assert_redirected_to mobile_text_path(assigns(:mobile_text))
  end

  test "should destroy mobile_text" do
    assert_difference('MobileText.count', -1) do
      delete :destroy, id: @mobile_text
    end

    assert_redirected_to mobile_texts_path
  end
end
