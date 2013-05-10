require 'test_helper'

class UserBoxResourceRelationshipControllerTest < ActionController::TestCase
  test "should get update_multiple" do
    get :update_multiple
    assert_response :success
  end

  test "should get destroy_multiple" do
    get :destroy_multiple
    assert_response :success
  end

end
