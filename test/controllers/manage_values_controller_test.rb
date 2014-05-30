require 'test_helper'

class ManageValuesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
