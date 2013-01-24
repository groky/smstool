require 'test_helper'

class MsgHandleControllerTest < ActionController::TestCase
  test "should get handle" do
    get :handle
    assert_response :success
  end

end
