require 'test_helper'

class BankCardsControllerTest < ActionController::TestCase
  setup do
    @bank_card = bank_cards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bank_cards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bank_card" do
    assert_difference('BankCard.count') do
      post :create, bank_card: { code: @bank_card.code, name: @bank_card.name, ower_name: @bank_card.ower_name }
    end

    assert_redirected_to bank_card_path(assigns(:bank_card))
  end

  test "should show bank_card" do
    get :show, id: @bank_card
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bank_card
    assert_response :success
  end

  test "should update bank_card" do
    patch :update, id: @bank_card, bank_card: { code: @bank_card.code, name: @bank_card.name, ower_name: @bank_card.ower_name }
    assert_redirected_to bank_card_path(assigns(:bank_card))
  end

  test "should destroy bank_card" do
    assert_difference('BankCard.count', -1) do
      delete :destroy, id: @bank_card
    end

    assert_redirected_to bank_cards_path
  end
end
