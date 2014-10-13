require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get loaddata" do
    get :loaddata
    assert_response :success
  end

end
