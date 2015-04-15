require 'test_helper'

class WithdrawRecordsControllerTest < ActionController::TestCase
  setup do
    @withdraw_record = withdraw_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:withdraw_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create withdraw_record" do
    assert_difference('WithdrawRecord.count') do
      post :create, withdraw_record: { amount: @withdraw_record.amount, bank_card: @withdraw_record.bank_card, bank_name: @withdraw_record.bank_name }
    end

    assert_redirected_to withdraw_record_path(assigns(:withdraw_record))
  end

  test "should show withdraw_record" do
    get :show, id: @withdraw_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @withdraw_record
    assert_response :success
  end

  test "should update withdraw_record" do
    patch :update, id: @withdraw_record, withdraw_record: { amount: @withdraw_record.amount, bank_card: @withdraw_record.bank_card, bank_name: @withdraw_record.bank_name }
    assert_redirected_to withdraw_record_path(assigns(:withdraw_record))
  end

  test "should destroy withdraw_record" do
    assert_difference('WithdrawRecord.count', -1) do
      delete :destroy, id: @withdraw_record
    end

    assert_redirected_to withdraw_records_path
  end
end
