require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get account" do
    get :account
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get detroy" do
    get :detroy
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
