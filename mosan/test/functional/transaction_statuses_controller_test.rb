require 'test_helper'

class TransactionStatusesControllerTest < ActionController::TestCase
  setup do
    @transaction_status = transaction_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transaction_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transaction_status" do
    assert_difference('TransactionStatus.count') do
      post :create, transaction_status: @transaction_status.attributes
    end

    assert_redirected_to transaction_status_path(assigns(:transaction_status))
  end

  test "should show transaction_status" do
    get :show, id: @transaction_status.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transaction_status.to_param
    assert_response :success
  end

  test "should update transaction_status" do
    put :update, id: @transaction_status.to_param, transaction_status: @transaction_status.attributes
    assert_redirected_to transaction_status_path(assigns(:transaction_status))
  end

  test "should destroy transaction_status" do
    assert_difference('TransactionStatus.count', -1) do
      delete :destroy, id: @transaction_status.to_param
    end

    assert_redirected_to transaction_statuses_path
  end
end
